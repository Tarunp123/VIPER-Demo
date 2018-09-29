//
//  PhotosWithMetadataDTO.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 29/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation

struct PhotosWithMetadataDTO: Decodable {
    
    let currentPage : Int
    let totalNoOfPages : Int
    let photosPerPage : Int
    let totalNoOfPhotos : Int
    let photos : [PhotoDTO]
    
    private enum CodingKeys : String, CodingKey{
        case currentPage = "page"
        case totalNoOfPages = "pages"
        case photosPerPage = "perpage"
        case photos = "photo"
        case totalNoOfPhotos = "total"
    }
}
