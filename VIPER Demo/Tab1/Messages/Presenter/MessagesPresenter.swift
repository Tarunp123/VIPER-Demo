//
//  MessagesPresenter.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 27/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation


class MessagesPresenter: MessagesPresenterProtocol {

    var view: MessagesViewProtocol?
    var router: MessagesRouterProtocol?
    var user: User?
    
    
    func viewDidLoad() {
        self.view?.setupView()
    }
    
    func numberOfMessages() -> Int {
        return self.user?.messages.count ?? 0
    }
    
    func messageAtIndex(index: Int) -> Message? {
        guard index < (self.user?.messages.count ?? 0) else{
            return nil
        }
        
        return self.user!.messages[index]
    }
    
    
}
