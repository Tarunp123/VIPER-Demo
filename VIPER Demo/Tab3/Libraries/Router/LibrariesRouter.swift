//
//  LibrariesRouter.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 29/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit

class LibrariesRouter: LibrariesRouterProtocol {
    
    static func createLibrariesModule() -> UIViewController {
        
        let view = LibrariesView()
        view.title = "Technology"
        view.navigationItem.title = "Libraries & Tools"
        let presenter = LibrariesPresenter()
        let router = LibrariesRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        
        return UINavigationController(rootViewController: view)
    }
    
}
