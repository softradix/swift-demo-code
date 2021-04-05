//
//  LoginVM.swift
//  Recipes
//
//  Created by Softradix Mac Mini on 31/03/21.
//

import Foundation

class LoginVM: BaseViewModel {
    
    // MARK: Variables
    var userService: UserServiceProtocol
    var userData : LoginModel?

    // MARK: Initialization
    // Putting dependency injection by paasing the service object in constructor and not giving the responsibility
    init(userService: UserServiceProtocol) {
      self.userService = userService
    }
    
    func loggeduserApi(params : [String : Any]? ,completion:@escaping( _ result : Bool)->()){
        ApiManager.shared.loginUser(params: params) { (model) in
            if model != nil {
                self.userData = model
                completion(true)

            } else {
                completion(false)
            }
        }
    }
}
