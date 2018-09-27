//
//  UsersRouter.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 9/26/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

class UsersRouter: UsersRouterProtocol {
    
    static func createUsersModule() -> UIViewController {
        let view = UsersView()
        let presenter = UsersPresenter()
        let interactor = UsersInteractor()
        let router = UsersRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return UINavigationController(rootViewController: view)
    }
    
    
}
