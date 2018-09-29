//
//  PhotoDTO.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 29/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation

struct PhotoDTO: Decodable {
    
    let id : String
    let farmId : Int
    let serverId : String
    let secret : String
    
    var thumbnailURLString : String{
        get{
            return "https://farm\(self.farmId).staticflickr.com/\(self.serverId)/\(self.id)_\(self.secret)_m.jpg"
        }
    }
    
    var URLString : String{
        get{
            return "https://farm\(self.farmId).staticflickr.com/\(self.serverId)/\(self.id)_\(self.secret)_c.jpg"
        }
    }
    
    private enum CodingKeys : String, CodingKey{
        case id
        case farmId = "farm"
        case serverId = "server"
        case secret
    }
}
