//
//  PostDTO.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 27/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation

struct PostDTO: Codable {
    let id : Int
    let userId : Int
    let title : String
    let body : String
}
