//
//  HTTPRequestor.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 27/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation


class HTTPRequestor{
    
    var url: URL!
    
    init(urlString: String){
        self.url = URL(string: urlString) ?? URL(string: "")
    }
    
    
    func makeRequest(closure: @escaping (_ response: Data?, _ error: Error?) -> Void){
        let request = URLRequest(url: self.url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let downloadTask =  session.dataTask(with: request) { (responseData, urlResponse, error) -> Void in
            
            //Error Encountered!
            guard error == nil else{
                closure(nil, error)
                return
            }
            
            //Response Data is nil
            guard let data = responseData else{
                closure(nil, error)
                return
            }
            
            //returing response data
            closure(data, error)
        }
        downloadTask.resume()
    }
    
}
