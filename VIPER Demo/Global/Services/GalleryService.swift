//
//  GalleryService.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 29/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import Moya

enum GalleryService{
    case getPhotos(apiKey: String, photosPerPage: Int, pageNo: Int)
    
    func getMethod() -> String {
        switch self {
        case .getPhotos(apiKey: _, photosPerPage: _, pageNo: _):
            return "flickr.photos.getRecent"
        }
    }
}

extension GalleryService: TargetType{
    var baseURL: URL {
        return URL(string: "https://api.flickr.com/services/rest/")!
    }
    
    var path: String {
        switch self {
        case .getPhotos(apiKey: _, photosPerPage: _, pageNo: _):
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPhotos(apiKey: _, photosPerPage: _, pageNo: _):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPhotos(let apiKey, let photosPerPage, let pageNo):
            return .requestParameters(parameters: ["method": self.getMethod(), "api_key" : apiKey, "per_page": "\(photosPerPage)", "page": "\(pageNo)", "format":"json", "nojsoncallback": 1], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getPhotos(apiKey: _, photosPerPage: _, pageNo: _):
            return ["Content-Type": "application/json"]
        }
    }
    
    
}
