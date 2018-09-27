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
    
    func viewDidLoad() {
        self.view?.setupView()
        interactor?.fetchUsersDataFromServer()
    }
    
    func showMessagesForUser(user: User) {
        
    }
    
    
}


extension UsersPresenter : UsersInteractorOutputProtocol{
    
}


