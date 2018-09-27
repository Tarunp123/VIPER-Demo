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
        guard index < self.users.count else {
            return nil
        }
        
        return self.users[index]
    }
    
    func didSelectUserAtIndex(index: Int) {
        guard index < self.users.count else {
            return
        }
        
        self.router?.presentMessagesScreenForUser(user: self.users[index])
    }
    
    
}


extension UsersPresenter : UsersInteractorOutputProtocol{
    
    func didFetchUsersDataFromServer(users: [User]) {
        self.users = users
        self.view?.updateView()
    }
}


