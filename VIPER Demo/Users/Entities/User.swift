//
//  User.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 9/26/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation


class User{
    var id : Int
    var messages : [UserMessage] = []
    
    init(id: Int) {
        self.id = id
    }
}
