//
//  AppManager.swift
//  StepUp
//
//  Created by gomad on 25/11/19.
//  Copyright © 2019 gomad. All rights reserved.
//

import Foundation
import UIKit

class AppManager: NSObject {
        
    /// This function will get presented ViewController
    static func getPresentedViewController() -> UIViewController?{
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    /// This function will convert json to jsonString
    static func convertJsonToJsonString(json:[String:Any])->String{
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        return jsonString
        
    }
    
}
