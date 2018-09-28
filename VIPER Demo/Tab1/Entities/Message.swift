//
//  Message.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 27/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation

class Message {
    
    var title : String
    var body : String
    
    //to store height required by Title and Label when cell is expanded
    var titleHeight : Float?
    var bodyHeight : Float?
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
