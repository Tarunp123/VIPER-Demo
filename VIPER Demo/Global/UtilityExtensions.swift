//
//  UtilityExtensions.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 27/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit

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


//MARK: UILabel
extension UILabel{
    
    static func heightForSingleLine(font: UIFont, fontPointSize pointSize: CGFloat) -> CGFloat {
        let label = UILabel()
        label.font = font.withSize(pointSize)
        label.numberOfLines = 0
        label.text = "Hello World"
        return label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).height
    }
    
    static func getSizeToFitText(text: String, font: UIFont, fontPointSize pointSize: CGFloat, maxWidth: CGFloat, maxHeight: CGFloat?) -> CGSize {
        let label = UILabel()
        label.font = font.withSize(pointSize)
        label.numberOfLines = 0
        label.text = text
        return label.sizeThatFits(CGSize(width: maxWidth, height: maxHeight ?? CGFloat.greatestFiniteMagnitude))
    }
}
