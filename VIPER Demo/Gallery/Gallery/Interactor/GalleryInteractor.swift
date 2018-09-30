//
//  GalleryInteractor.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 29/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import Moya

class GalleryInteractor: GalleryInteractorInputProtocol {
 
    var presenter : GalleryInteractorOutputProtocol?
    
    private var totalNoOfPhotosInServer = 0
    private var totalNoOfPagesInServer = -1
    private var noOfPagesFetched = 0
    private var photosPerPage = 20
    private var flickrAPIKey = "e449b259146e14b0d55e770fb3577436"

    
    private var isFetchingData = false
    
    func fetchNextPageFromServer() {
        guard !self.isFetchingData else{
            return
        }
        
        if totalNoOfPagesInServer == -1{    //initial fetch
            self.noOfPagesFetched = 0
        }else{      //subsequent fetches after initial fetch
            guard noOfPagesFetched < totalNoOfPagesInServer else{
                return
            }
        }
        self.fetchImagesForPageNo(pageNo: self.noOfPagesFetched + 1, apiKey: self.flickrAPIKey, photosPerPage: self.photosPerPage)
    }
    
    func totalNoOfPhotosPresentInServer() -> Int {
        return self.totalNoOfPhotosInServer
    }
    
   private var photoProvider = MoyaProvider<GalleryService>()
    
    private func fetchImagesForPageNo(pageNo: Int, apiKey: String, photosPerPage: Int){
        self.isFetchingData = true

        photoProvider.request(.getPhotos(apiKey: apiKey, photosPerPage: photosPerPage, pageNo: pageNo)) { (result) in
            
            self.isFetchingData = false
            
            switch result{
            case .failure(let error):
                self.presenter?.didFailToFetchImagesWithError(error: error)
                
            case .success(let response):
                do{
                    let flickrResponse = try JSONDecoder().decode(FlickrResponseDTO.self, from: response.data)
                    self.totalNoOfPhotosInServer = flickrResponse.photosWithMetadata.totalNoOfPhotos
                    self.totalNoOfPagesInServer = flickrResponse.photosWithMetadata.totalNoOfPages
                    self.noOfPagesFetched += 1
                    self.presenter?.didFetchNextPageFromServer(photos: flickrResponse.photosWithMetadata.photos)

                }catch(let err){
                    self.presenter?.didFailToFetchImagesWithError(error: err)
                }
            }
        }
        
        
    }
    
    
    
    
}


