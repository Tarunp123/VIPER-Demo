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
        view.title = "Users"
        view.navigationItem.title = "All Users"
        
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
    
    func presentMessagesScreen(from view: UsersViewProtocol, forUser user: User){
        
        if let usersView = view as? UIViewController{
            let messagesView = MessagesRouter.createMessagesModuleForUser(user: user)
            usersView.navigationController?.pushViewController(messagesView, animated: true)
        }
        
    }
    
    
}
