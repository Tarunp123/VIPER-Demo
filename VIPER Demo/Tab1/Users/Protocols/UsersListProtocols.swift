//
//  UsersListProtocols.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 9/26/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

protocol UsersRouterProtocol {
    static func createUsersModule() -> UIViewController
}


protocol UsersPresenterProtocol{
    var view : UsersViewProtocol? {get set}
    var interactor : UsersInteractorInputProtocol? {get set}
    var router : UsersRouterProtocol? {get set}
    
    func viewDidLoad()
    func showMessagesForUser(user: User)
}


protocol UsersViewProtocol{
    var presenter: UsersPresenterProtocol? {get set}
    
    func setupView()
    
    func updateView()
}




protocol UsersInteractorInputProtocol {
    var presenter : UsersInteractorOutputProtocol? {get set}

    func fetchUsersDataFromServer()
    
}


protocol UsersInteractorOutputProtocol {
    func didFetchUsersDataFromServer(users: [User])
}

