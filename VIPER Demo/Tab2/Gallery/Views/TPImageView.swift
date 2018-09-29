//
//  TPImageView.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 29/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

class TPImageView: UIImageView {

    static var imageCache = NSCache<AnyObject, AnyObject>()

    private var imageURLString : String?
    
    
    func setImageFromURL(urlString: String) {
        
        self.imageURLString = urlString
        self.image = nil
        
        if let cachedImage = TPImageView.imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            print("CACHE HIT")
            self.image = cachedImage
            return
        }
        
        
        
        let httpRequester = HTTPRequestor(urlString: urlString)
        httpRequester.makeRequest { (data, error) in
            guard error == nil else{
                print(error!)
                return
            }
            
            if let imageData = data{
                if let image = UIImage(data: imageData){
                    TPImageView.imageCache.setObject(image, forKey: urlString as AnyObject)
                    
                    if self.imageURLString == urlString{
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                    
                }
            }
            
        }
        
        
    }

}
