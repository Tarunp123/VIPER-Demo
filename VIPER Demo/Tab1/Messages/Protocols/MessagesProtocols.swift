//
//  MessagesProtocols.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 27/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation


protocol MessagesRouterProtocol {
    static func createMessagesModuleForUser(user: User) -> MessagesView
    
}


protocol MessagesViewProtocol {
    var presenter : MessagesPresenterProtocol? {get set}
    
    func setupView()
}


protocol MessagesPresenterProtocol {
    var view : MessagesViewProtocol? {get set}
    var router : MessagesRouterProtocol? {get set}
    var user : User? {get set}
    
    func viewDidLoad()
    
    func numberOfMessages() -> Int
    
    func messageAtIndex(index: Int) -> Message?
}
