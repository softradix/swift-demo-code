//
//  SignupVM.swift
//  Recipes
//
//  Created by Softradix Mac Mini on 31/03/21.
//

import Foundation

class SignupVM: BaseViewModel {
    
    // MARK: Variables
    var userService: UserServiceProtocol
    var userData : UserDataModel?

    // MARK: Initialization
    // Putting dependency injection by paasing the service object in constructor and not giving the responsibility
    init(userService: UserServiceProtocol) {
      self.userService = userService
    }
    
    func signUpUserApi(params : [String : Any]? ,completion:@escaping( _ result : Bool)->()){
        ApiManager.shared.signUpUser(params: params) { (model) in
            if model != nil {
                self.userData = model
                completion(true)

            } else {
                completion(false)
            }
        }
    }
}
