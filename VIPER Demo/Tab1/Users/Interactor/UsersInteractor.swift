//
//  UsersInteractor.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 9/27/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation


class UsersInteractor: UsersInteractorInputProtocol {
    
    var presenter: UsersPresenterProtocol?
    
    private let postsURLString = "http://jsonplaceholder.typicode.com/posts"
    
    func fetchUsersDataFromServer() {
        
        let httpRequestor = HTTPRequestor(urlString: self.postsURLString)
        httpRequestor.makeRequest { (responseData, error) in
            if let data = responseData{
                if let posts = try? JSONDecoder().decode([PostDTO].self, from: data){
                    print("POSTS = \(posts.count)")
                }
            }
        }
    
    }
    
    
}
