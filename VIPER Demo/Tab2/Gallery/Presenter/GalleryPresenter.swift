//
//  GalleryPresenter.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 29/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation

class GalleryPresenter: GalleryPresenterProtocol {

    
    var view: GalleryViewProtocol?
    var router: GalleryRouterProtocol?
    var interactor: GalleryInteractorInputProtocol?
    
    private var photos = [PhotoDTO]()
    
    func viewDidLoad() {
        self.view?.setupView()
        self.interactor?.fetchNextPageFromServer()
    }
    
    func totalNoOfPhotos() -> Int {
        return self.interactor?.totalNoOfPhotosPresentInServer() ?? 0
    }
    
    func numberOfPhotosToShow() -> Int {
        return self.photos.count
    }
    
    func photoAtIndex(index: Int) -> PhotoDTO? {
        guard index < self.photos.count else{
            return nil
        }
        
        //fetch next batch if user has scrolled close to end
        if index >= (self.photos.count - 6) && self.photos.count < (self.interactor?.totalNoOfPhotosPresentInServer() ?? 0){
            self.interactor?.fetchNextPageFromServer()
            self.view?.showLoadingIndicator()
        }
        
        return self.photos[index]
    }
    
    func didSelectPhotoAtIndex(index: Int) {
        self.view?.expandPhotoAtIndex(index: index)
    }
    
    
}


extension GalleryPresenter : GalleryInteractorOutputProtocol{
    
    func didFetchNextPageFromServer(photos: [PhotoDTO]) {
        self.photos.append(contentsOf: photos)
        self.view?.updateView()
        self.view?.removeLoadingIndicator()
    }
    
    func didFailToFetchImagesWithError(error: Error) {
        print(error)
        self.view?.removeLoadingIndicator()
    }
    
    
}
