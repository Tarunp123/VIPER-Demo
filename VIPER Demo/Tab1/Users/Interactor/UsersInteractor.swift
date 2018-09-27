//
//  UsersInteractor.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 9/27/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation


class UsersInteractor: UsersInteractorInputProtocol {
    
    var presenter: UsersInteractorOutputProtocol?
    
    private let postsURLString = "http://jsonplaceholder.typicode.com/posts"
    
    func fetchUsersDataFromServer() {
        
        let httpRequestor = HTTPRequestor(urlString: self.postsURLString)
        httpRequestor.makeRequest { (responseData, error) in
            
            //Error Checking
            guard error == nil else{
                print(error.debugDescription)
                return
            }
            
            if let data = responseData{
                do{
 
                    let posts = try JSONDecoder().decode([PostDTO].self, from: data)
                    //parsing done
                    
                    //create Users and their Messages
                    var usersMap = Dictionary<Int, User>()
                    
                    for index in 0..<posts.count{
                        guard posts[index].userId != nil && posts[index].title != nil && posts[index].body != nil else{
                            continue;
                        }
                        
                        if usersMap[posts[index].userId!] == nil{
                            //User doesn't exists in map
                            //Add new User
                            usersMap[posts[index].userId!] = User(id: posts[index].userId!)
                        }
                        //append new message
                        usersMap[posts[index].userId!]!.messages.append(Message(title: posts[index].title!, body: posts[index].body!))
                    }
                    
                    //Sort Users based on userId
                    let users = Array(usersMap.values).sorted(by: { (user1, user2) -> Bool in
                        return user1.id < user2.id
                    })
                    
                    self.presenter?.didFetchUsersDataFromServer(users: users)
                    
                }catch{
                    //error
                    print("ERROR = \(error)")
                }
            }
        }
    
    }
    
    
}
