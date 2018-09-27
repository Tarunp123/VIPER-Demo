//
//  UsersPresenter.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 9/27/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation


class UsersPresenter: UsersPresenterProtocol {

    var view: UsersViewProtocol?
    var interactor: UsersInteractorInputProtocol?
    var router: UsersRouterProtocol?
    
    private var users = [User]()
    
    func viewDidLoad() {
        self.view?.setupView()
        interactor?.fetchUsersDataFromServer()
    }
    
    func numberOfUsers() -> Int {
        return self.users.count
    }
    
    func userAtIndex(index: Int) -> User? {
        return index < self.users.count ? self.users[index] : nil
    }
    
    func showMessagesForUser(user: User) {
        
    }
    
}


extension UsersPresenter : UsersInteractorOutputProtocol{
    func didFetchUsersDataFromServer(users: [User]) {
//        print("didFetchUsersDataFromServer = \(users.count)")
        self.users = users
        self.view?.updateView()
    }
}


