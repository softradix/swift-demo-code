//
//  WebServices.swift
//  Sorsr
//
//  Created by user on 31/03/20.
//  Copyright © 2020 aulakh. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class WebServices : NSObject {
    
    static let shared = WebServices()
    private var alamofireSessionManager:SessionManager?
    
    private override init() {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60 // seconds
        configuration.timeoutIntervalForResource = 60
        
        self.alamofireSessionManager = Alamofire.SessionManager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies:["34.195.198.5:8081":.disableEvaluation]))
        
    }
    
    /*Get Method
     This is GET Method to Hit API's Of GET Method.
     */
    func getRequest(parameters:[String:Any]?,headers:[APIHeaders],apiEndPoint:String, completion: @escaping success){
        if HelpingVC.shared.isInternetConnectionAvailable(){

        let URL = ApiConstants.baseUrl + apiEndPoint
        let headers: HTTPHeaders? = self.appendHeaders(headerTypes:headers)

        alamofireSessionManager!.request(URL,
                                         method:.get,
                                         parameters: parameters ?? nil,
                                         encoding: URLEncoding.default,
                                         headers: headers)
            .responseJSON(completionHandler: { (response) in
                guard response.result.isSuccess else {
                    
                    AlertViewManager.showAlert(message: (response.result.error?.localizedDescription)!, alertButtonTypes: [.Okay])
                    return
                }
                guard let value = response.result.value,
                    let data = value as? [String: Any] else {
                        
                        AlertViewManager.showAlert(message: (response.result.error?.localizedDescription)!, alertButtonTypes: [.Okay])
                        return
                }
                              
                let statusCode = response.response?.statusCode
                if  statusCode == APIStatusCode.success.rawValue{//Return success data
                    completion(data)
                }else{// Handles Validation Errors
                    
                    let messa = data[Keys.kMessage]  as? String ?? ""
                    self.handleErrorUsingStatusCode(statusCode: APIStatusCode(rawValue: statusCode!)!, errorMessage: messa)
                }
            })
            
        }
    }


    
    /*PUT Method
     This is POST Method to Hit API's Of POST Method.
     */
    func putRequest(parameters:[String:Any],headers:[APIHeaders],apiEndPoint:String, completion: @escaping success){

       // let encoder = JSONEncoder()
        //let jsonData = try! encoder.encode(parameters)
        if HelpingVC.shared.isInternetConnectionAvailable(){

        let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: [])

        let URLs = ApiConstants.baseUrl + apiEndPoint
        let urlStr  = URL(string: URLs)
        var request = URLRequest.init(url:urlStr!)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(DataManager.shared.AuthToken)", forHTTPHeaderField: "Authorization")

        request.httpBody = jsonData

           Alamofire.request(request).responseJSON { response in
               switch response.result {
               case .success( _):
                   print ("finish")
                   guard let value = response.result.value,
                                    let data = value as? [String: Any] else {
                                        
                                        AlertViewManager.showAlert(message: (response.result.error?.localizedDescription)!, alertButtonTypes: [.Okay])
                                        return
                                }

                let statusCode = response.response?.statusCode
                if  statusCode == APIStatusCode.success.rawValue{//Return success data
                    completion(data)
                }else{// Handles Validation Errors
                    
                    self.handleErrorUsingStatusCode(statusCode: APIStatusCode(rawValue: statusCode!)!, errorMessage: (data[Keys.kMessage] as? String) ?? "")
                }
                  
               case .failure( _):
                
                                   AlertViewManager.showAlert(message: (response.result.error?.localizedDescription)!, alertButtonTypes: [.Okay])
                break
               }
           }
        
        }
      /*  alamofireSessionManager!.request(URLs,
                                         method:.put,
                                         parameters: parameters,
                                         encoding: URLEncoding.default,
                                         headers: headers)
            .responseJSON(completionHandler: { (response) in

                guard response.result.isSuccess else {
                    
                    AlertViewManager.showAlert(message: (response.result.error?.localizedDescription)!, alertButtonTypes: [.Okay])
                    return
                }

                guard let value = response.result.value,
                    let data = value as? [String: Any] else {
                        
                        AlertViewManager.showAlert(message: (response.result.error?.localizedDescription)!, alertButtonTypes: [.Okay])
                        return
                }

                let statusCode = response.response?.statusCode
                if  statusCode == APIStatusCode.success.rawValue{//Return success data
                    completion(data)
                }else{// Handles Validation Errors
                    
                    self.handleErrorUsingStatusCode(statusCode: APIStatusCode(rawValue: statusCode!)!, errorMessage: (data[Keys.kMessage] as? String) ?? "")
                }
            })*/
    }
    
    
    func postRequest(parameters:[String:Any]?,headers:[APIHeaders],apiEndPoint:String, completion: @escaping success){
        if HelpingVC.shared.isInternetConnectionAvailable(){

        let URL = ApiConstants.baseUrl + apiEndPoint
        
        let headers: HTTPHeaders? = self.appendHeaders(headerTypes:headers) ?? nil
        
        alamofireSessionManager!.request(URL,
                                         method:.post,
                                         parameters: parameters ?? nil,
                                         encoding: JSONEncoding.prettyPrinted,
                                         headers: headers)
            .responseJSON(completionHandler: { (response) in
                debugPrint(response)
                guard response.result.isSuccess else {
                    
                    AlertViewManager.showAlert(message: (response.result.error?.localizedDescription)!, alertButtonTypes: [.Okay])
                    return
                }
                
                guard let value = response.result.value,
                    let data = value as? [String: Any] else {
                        
                        AlertViewManager.showAlert(message: (response.result.error?.localizedDescription)!, alertButtonTypes: [.Okay])
                        return
                }
                
                let statusCode = response.response?.statusCode
                if  statusCode == APIStatusCode.success.rawValue{//Return success data
                    completion (data)
                }else{// Handles Validation Errors
                    
                    self.handleErrorUsingStatusCode(statusCode: APIStatusCode(rawValue: statusCode!)!, errorMessage: (data[Keys.kMessage] as? String) ?? "")
                }
            })
            
        }
    }

    
    /*Multipart Method
     This is MULTIPART Method to Hit API's Of MULTIPART Method.
     */
    func multipartRequest(parameters:[String:Any]?,headers:[APIHeaders],fileName:String,images:[UIImage]?, apiEndPoint:String, completion: @escaping success){
        if HelpingVC.shared.isInternetConnectionAvailable(){
     
        let URL = ApiConstants.baseUrl + apiEndPoint
        let headers: HTTPHeaders? = self.appendHeaders(headerTypes:headers) ?? nil
        
        alamofireSessionManager!.upload(multipartFormData: { multipartFormData in
            // import image to request
            if images != nil {
                for imageData in images! {
                    
                    let data = imageData.jpegData(compressionQuality: 0.25)//UIImage.jpegData(imageData)
                    multipartFormData.append(data!, withName: fileName, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    
                }
            }
            for (key, value) in parameters ?? [:] {
                let data = (value as! String).data(using: String.Encoding.utf8)!
                multipartFormData.append(data, withName: key)
            }
            
        }, to: URL,
           method:.post,
           headers: headers,
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    let data = response.result.value
                    if data != nil {
                         completion((data as? [String : Any])!)
                    }else{
                        

                        AlertViewManager.showAlert(message:"Session timed out", alertButtonTypes: [.Okay])

                    }
                }
            case .failure(let error):
                
                AlertViewManager.showAlert(message: error.localizedDescription, alertButtonTypes: [.Okay])
            }
        })
            
        }
}
    
    func multipartRequestWithGet(parameters:[String:Any]?,headers:[APIHeaders],fileName:String,images:[UIImage]?, apiEndPoint:String, completion: @escaping success){
        if HelpingVC.shared.isInternetConnectionAvailable(){
     
        let URL = ApiConstants.baseUrl + apiEndPoint
        let headers: HTTPHeaders? = self.appendHeaders(headerTypes:headers) ?? nil
        
        alamofireSessionManager!.upload(multipartFormData: { multipartFormData in
            // import image to request
            if images != nil {
                for imageData in images! {
                    
                    let data = imageData.jpegData(compressionQuality: 0.25)//UIImage.jpegData(imageData)
                    multipartFormData.append(data!, withName: fileName, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    
                }
            }
            if parameters != nil {
                for (key, value) in parameters! {
                    let data = (value as! String).data(using: String.Encoding.utf8)!
                    multipartFormData.append(data, withName: key)
                }
            }
          
            
        }, to: URL,
           method:.get,
           headers: headers,
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    let data = response.result.value
                    if data != nil {
                         completion((data as? [String : Any])!)
                    }else{
                        

                        AlertViewManager.showAlert(message:"Session timed out", alertButtonTypes: [.Okay])

                    }
                }
            case .failure(let error):
                
                AlertViewManager.showAlert(message: error.localizedDescription, alertButtonTypes: [.Okay])
            }
        })
            
        }
}
    
    /*
     This function will return headers
     */
    private func appendHeaders(headerTypes:[APIHeaders]?) -> [String:String]? {
        
        let headers = NSMutableDictionary()
        if headerTypes != nil {
            for header in headerTypes!{
                
                switch header {
                case .accept:
                    headers["Accept"] = "application/json"
                    break
                case .contentType:
                    headers["Content-Type"] = "application/json"
                    break
                case .authorization:
                    headers["Authorization"] = "Bearer \(DataManager.shared.AuthToken)"
                    break
                case .apiKey:
                    headers["App-Key"] = "8UI93555755344234IZ"
                    break
                }
            }
        }
        return headers.count < 0 ? nil:headers as? [String:String]
    }
    
    /*
     This function will handle errors according to status code
     */
    private func handleErrorUsingStatusCode(statusCode:APIStatusCode,errorMessage:String){
        
        switch statusCode {
        case .unAuthorized:
            AlertViewManager.showAlert(message: errorMessage, alertButtonTypes: [.Okay])
            break
        case .pageNotFound:
            AlertViewManager.showAlert(message: errorMessage, alertButtonTypes: [.Okay])
            break
        case .unexpected:
            AlertViewManager.showAlert(message: errorMessage, alertButtonTypes: [.Okay])
            break
        default:
            AlertViewManager.showAlert(message: errorMessage, alertButtonTypes: [.Okay])
            break
        }
    }
  
    
}
