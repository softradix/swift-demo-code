//
//  Storyboard.swift
//  StepUp
//
//  Created by Prateek Arora on 17/11/20.
//  Copyright © 2020 gomad. All rights reserved.
//

import Foundation
import UIKit

enum StoryboardName : String
{
    case main        = "Main"
  
}

enum VCIdentifier : String
{
    case logiVC = "LoginVC"
    case signupVC = "SignupVC"
    case forgotPassVC = "ForgotPassVC"
    case changePassvc = "ChangePassVC"
    case recipesVC = "RecipesViewController"
    case recipeDetail = "ReceipeDetailVC"
    
}

class NavigationHelper
{
    static let shared = NavigationHelper()
    
    private init(){}
    
    func viewController(_ id : VCIdentifier, _ storyBoard : StoryboardName) -> UIViewController
    {
        let vc = UIStoryboard.init(name: storyBoard.rawValue, bundle: nil).instantiateViewController(withIdentifier: id.rawValue)
        
        return vc
    }
}
