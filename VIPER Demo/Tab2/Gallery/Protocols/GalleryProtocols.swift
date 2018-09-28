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
}

protocol GalleryPresenterProtocol {
    var view : GalleryViewProtocol? {get set}
    var router : GalleryRouterProtocol? {get set}
    
    func viewDidLoad()
    
    func numberOfPhotos() -> Int
//    func photoAtIndex(index: Int) -> PhotoDTO
    
    
}


protocol GalleryInteractorInputProtocol {
    func fetchRecentImagesFromServer()
}

protocol GalleryInteractorOutputProtocol {
    var presenter : GalleryPresenterProtocol? {get set}
}
