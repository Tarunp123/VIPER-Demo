//
//  GalleryProtocols.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 9/28/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

protocol GalleryRouterProtocol {
    static func createGalleryModule() -> UIViewController
    
}


protocol GalleryViewProtocol {
    var presenter : GalleryPresenterProtocol? {get set}
    
    func setupView()
    func updateView()
}

protocol GalleryPresenterProtocol {
    var view : GalleryViewProtocol? {get set}
    var router : GalleryRouterProtocol? {get set}
    var interactor : GalleryInteractorInputProtocol? {get set}
    
    func viewDidLoad()
    
    func totalNoOfPhotos() -> Int
    func numberOfPhotosToShow() -> Int
    func photoAtIndex(index: Int) -> PhotoDTO?
    
    
}


protocol GalleryInteractorInputProtocol {    
    var presenter : GalleryInteractorOutputProtocol? {get set}
    
    func totalNoOfPhotosPresentInServer() -> Int
    func fetchNextPageFromServer()
    
}

protocol GalleryInteractorOutputProtocol {
    
    func didFetchNextPageFromServer(photos: [PhotoDTO])
    
    func didFailToFetchImagesWithError(error: Error)
}
