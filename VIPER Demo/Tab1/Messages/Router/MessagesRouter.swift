//
//  MessagesRouter.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 27/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation

class MessagesRouter: MessagesRouterProtocol {
    
    static func createMessagesModuleForUser(user: User) -> MessagesView {
        
        let view = MessagesView()
        let presenter = MessagesPresenter()
        let router = MessagesRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.user = user
        
        return view
    }
    
    
}
