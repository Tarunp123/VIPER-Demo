//
//  GalleryRouter.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 9/28/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit

class GalleryRouter: GalleryRouterProtocol {
    
    static func createGalleryModule() -> UIViewController {
        
        let view = GalleryView()
        let presenter = GalleryPresenter()
        let router = GalleryRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        
        return UINavigationController(rootViewController: view)
    
    }
    
}
