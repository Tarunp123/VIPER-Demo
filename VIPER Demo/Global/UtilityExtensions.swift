//
//  UtilityExtensions.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 27/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation


//MARK:- Data
extension Data{
    
    func getJSON() -> Any?{
        
        do{
            let json = try JSONSerialization.jsonObject(with: self, options: .mutableLeaves)
            return json
        }catch{
            //Handle error
            print("Error: Could not convert Data to JSON!")
        }
        
        return nil
    }
    
}
