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
        view.title = "Gallery"
        view.navigationItem.title = "Recent Photos"
        
        let presenter = GalleryPresenter()
        let router = GalleryRouter()
        let interactor = GalleryInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return UINavigationController(rootViewController: view)
    
    }
    
}
