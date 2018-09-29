//
//  GalleryInteractor.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 29/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation

class GalleryInteractor: GalleryInteractorInputProtocol {
 
    var presenter : GalleryInteractorOutputProtocol?
    
    private var totalNoOfPhotosInServer = 0
    private var totalNoOfPagesInServer = -1
    private var noOfPagesFetched = 0
    private var recordsPerPage = 20
    private var flickrAPIKey = "e449b259146e14b0d55e770fb3577436"
    
    lazy private var flickerApiURI = "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=\(self.flickrAPIKey)&format=json&nojsoncallback=1&per_page=\(self.recordsPerPage)&page="
    
    
    private var isFetchingData = false
    
    func fetchNextPageFromServer() {
        guard !self.isFetchingData else{
            return
        }
        
        if totalNoOfPagesInServer == -1{    //initial fetch
            self.noOfPagesFetched = 0
            self.fetchImagesFromURI(uri: self.flickerApiURI+"\(self.noOfPagesFetched + 1)")
        }else{      //subsequent fetches after initial fetch
            guard noOfPagesFetched < totalNoOfPagesInServer else{
                return
            }
            self.fetchImagesFromURI(uri: self.flickerApiURI+"\(self.noOfPagesFetched + 1)")
        }
        
    }
    
    func totalNoOfPhotosPresentInServer() -> Int {
        return self.totalNoOfPhotosInServer
    }
    
    
    private func fetchImagesFromURI(uri: String){
        self.isFetchingData = true
        
        let requester = HTTPRequestor(urlString: uri)
        requester.makeRequest { (data, error) in
            
            self.isFetchingData = false
            
            guard error == nil else{
                self.presenter?.didFailToFetchImagesWithError(error: error!)
                return
            }
            
            if let photosData = data{
                do{
                    let flickrResponse = try JSONDecoder().decode(FlickrResponseDTO.self, from: photosData)
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


