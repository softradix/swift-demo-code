//
//  HelpingVC.swift
//  Sorsr
//
//  Created by user on 31/03/20.
//  Copyright © 2020 aulakh. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

class HelpingVC: NSObject {
    
    //MARK:- Variables
    static let shared = HelpingVC()
   
    func delay(seconds:Double, completion: @escaping() -> Void ){
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    func timeFormatted(totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //  let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func jsonToString(json: AnyObject) -> String{
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print(convertedString ?? "") // <-- here is ur string
            return convertedString ?? ""
        } catch let myJSONError {
            print(myJSONError)
            return ""
        }

    }
    
    //Set body parameters for API's
    func setBodyParams(request:Any) -> NSMutableDictionary{
        //Initialize a NSMutableDictionary
          let dataDic = NSMutableDictionary()
        //Now
          let requestMirror = Mirror(reflecting: request)
          for child in requestMirror.children{
              dataDic.setValue(child.value, forKey: child.label!)
          }
         return dataDic
      }
    
 
    func showAlertWithCompletion(title:String,message:String, completionHandler: @escaping (_ status: Bool?) -> ()){
         DispatchQueue.main.async {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            completionHandler(true)
        }
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        //            completionHandler(false)
        //        }
        alert.addAction(okAction)
        // alert.addAction(cancelAction)
        alert.show()
        //  self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlertWithCompletionYesNo(title:String,message:String, completionHandler: @escaping (_ status: Bool?) -> ()){
          DispatchQueue.main.async {
         let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
             completionHandler(true)
         }
                 let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                     completionHandler(false)
                 }
         alert.addAction(okAction)
          alert.addAction(cancelAction)
         alert.show()
         //  self.present(alert, animated: true, completion: nil)
         }
     }
    
    func showAlert(message:String){
        DispatchQueue.main.async {
            
        
        let alert = UIAlertController(title: Constants.AppInfo.APP_NAME, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        //
        //        }
        alert.addAction(okAction)
        // alert.addAction(cancelAction)
        alert.show()
        //self.present(alert, animated: true, completion: nil)
        }
    }
    
    func isInternetConnectionAvailable() -> Bool{
        let status = Reachability().connectionStatus()
                switch status {
                case .unknown, .offline:
                    // Show alert if internet not available.
                  self.showAlert(message:Constants.Alert_Messages.noInternetConnection)
                    return false
                default:
                   return true
                  
                }
    }
    
    func resetRootVC(from:UIViewController,rootIdentifier:String){
        DispatchQueue.main.async {
              guard let rootVC = from.storyboard?.instantiateViewController(withIdentifier: rootIdentifier) else {
                      return
                  }
                  
                  let navigationController = UINavigationController(rootViewController: rootVC)
                  UIApplication.shared.windows.first?.rootViewController = navigationController
                  UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
      
    }
    
    func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "1528011627") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

public extension UIAlertController {
    func show() {
        if #available(iOS 13.0, *) {
            if var topController = UIApplication.shared.keyWindow?.rootViewController  {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(self, animated: true, completion: nil)
            }
        }else{
            let win = UIWindow(frame: UIScreen.main.bounds)
            let vc = UIViewController()
            vc.view.backgroundColor = .clear
            win.rootViewController = vc
            win.windowLevel = UIWindow.Level.alert + 1  // Swift 3-4: UIWindowLevelAlert + 1
            win.makeKeyAndVisible()
            vc.present(self, animated: true, completion: nil)
        }
    }
}

