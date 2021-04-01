//
//  ApiManager.swift
//  OnceOverInspection
//


import Foundation
import UIKit
import Alamofire
import ObjectMapper

typealias success = ([String: Any]) -> ()
typealias failure = (Error) -> ()

class ApiManager: NSObject {
    
    static let shared = ApiManager()
  
    func getMyReceipesData(params : [String :Any]?,completionHandler:@escaping(_ responseData:[Recipes]?, _ errorMsg : String?)->()) {
        WebServices.shared.postRequest(parameters: params, headers: [.accept, .authorization], apiEndPoint: ApiConstants.fetchRecipes, completion: { (response) in
            let data : NSDictionary = response as NSDictionary
            debugPrint(data)

            let message = data.value(forKey: "message") as? String
            let succes = data.value(forKey: "success") as? Bool

            if succes ?? false {
                let recipes = Mapper<Recipes>().mapArray(JSONArray:response["recipes"] as! [[String : Any]])
                completionHandler(recipes, nil)
            }else {
                //AlertViewManager.showAlert(message: message ?? "", alertButtonTypes: [.Okay])
                completionHandler(nil, message ?? "")
            }
        }) 
    }
    
  /*  func loginUser(params : [String :Any]?,completionHandler:@escaping(_ responseData:LoginModel?)->()) {
        
        WebServices.shared.multipartRequest(parameters: params, headers:[.accept] , fileName: "", images: nil, apiEndPoint: ApiConstants.login) { (response) in
            let data : NSDictionary = response as NSDictionary
       
            let message = data.value(forKey: "message") as? String
            let succes = data.value(forKey: "success") as? Bool

            if succes ?? false{
                let token = data.value(forKey: "token") as? String
                DataManager.shared.AuthToken = token ?? ""
                let userdata = Mapper<LoginModel>().map(JSON: response["user"] as! [String : AnyObject])
                LoginModel.curentUser = userdata
                completionHandler(userdata)
                
            }
            else {
                AlertViewManager.showAlert(message: message ?? "", alertButtonTypes: [.Okay])
                completionHandler(nil)
            }


        }
    }
    
    func signUpUser(params : [String :Any]?,completionHandler:@escaping(_ responseData:UserDataModel?)->()) {
        
        WebServices.shared.multipartRequest(parameters: params, headers:[.accept] , fileName: "", images: nil, apiEndPoint: ApiConstants.register) { (response) in
            let data : NSDictionary = response as NSDictionary
       
            let message = data.value(forKey: "message") as? String
            let succes = data.value(forKey: "success") as? Bool

            if succes ?? false{
                let token = data.value(forKey: "token") as? String
                DataManager.shared.AuthToken = token ?? ""
                let userdata = Mapper<UserDataModel>().map(JSON: response["user"] as! [String : AnyObject])
                UserDataModel.curentUser = userdata
                completionHandler(userdata)
                
            }
            else {
                AlertViewManager.showAlert(message: message ?? "", alertButtonTypes: [.Okay])
                completionHandler(nil)
            }


        }
    }*/
    
    
}
