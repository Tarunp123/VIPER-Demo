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
    func setupView()
}
