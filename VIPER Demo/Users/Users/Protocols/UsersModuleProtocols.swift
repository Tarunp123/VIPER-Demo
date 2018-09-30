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
    
    func presentMessagesScreen(from view: UsersViewProtocol, forUser user: User)
    

}


protocol UsersPresenterProtocol{
    var view : UsersViewProtocol? {get set}
    var interactor : UsersInteractorInputProtocol? {get set}
    var router : UsersRouterProtocol? {get set}
    
    func viewDidLoad()
    
    func numberOfUsers() -> Int
    
    func userAtIndex(index: Int) -> User?
    
    func didSelectUserAtIndex(index: Int)
    
}


protocol UsersViewProtocol{
    var presenter: UsersPresenterProtocol? {get set}
    
    func setupView()
    
    func updateView()
    
    func showLoadingIndicator()
    func removeLoadingIndicator()
    
    func showError(messageString: String)
}




protocol UsersInteractorInputProtocol {
    var presenter : UsersInteractorOutputProtocol? {get set}

    func fetchUsersDataFromServer()
    
}


protocol UsersInteractorOutputProtocol {
    func didFetchUsersDataFromServer(users: [User])
    func didFailToFetchUsersDataFromServerWithError(error: Error)
}

