//
//  FlickrResponseDTO.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 29/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation

struct FlickrResponseDTO: Decodable {
    let photosWithMetadata: PhotosWithMetadataDTO
    
    private enum CodingKeys: String, CodingKey{
        case photosWithMetadata = "photos"
    }
}
