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
    
    
    
    func viewDidLoad() {
        self.view?.setupView()
    }
    
    func numberOfPhotos() -> Int {
        return 0
    }
    
}


extension GalleryPresenter : GalleryInteractorOutputProtocol{
    
}
