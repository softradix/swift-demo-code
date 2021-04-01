//
//  ApiConstant.swift
//  EmployeeHealth
//
//  Created by Surjeet Singh on 15/03/2019.
//  Copyright © 2019 Surjeet Singh. All rights reserved.
//

import UIKit

class ApiConstants  {
    // Copy base url here
    #if DEVELOPMENT
    static let baseUrl                  = "https://swate.softradixtechnologies.com/api/"
    #else
    static let baseUrl                  = "https://swate.softradixtechnologies.com/api/"
    #endif
    
 
    
    
    static let login                    = "auth/login"
    static let register                 = "auth/register"
    static let forgotPassword           = "auth/forgot_password"
    static let resetPassword            = "auth/update_password"
    static let changepassword           = "change_password"
    static let addUserInfo          = "add_user_info"
    static let fetchRecipes         = "get_recipes"

}

