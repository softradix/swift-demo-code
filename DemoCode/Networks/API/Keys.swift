//
//  Keys.swift
//  StepUp
//
//  Created by gomad on 29/11/19.
//  Copyright © 2019 gomad. All rights reserved.
//

import Foundation
import UIKit

enum SocialType : String {
    case email = "0"
    case twitter = "1"
    case facebook = "2"
    case google = "3"
    
}
class Keys: NSObject {
    static let objAppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let KDeviceUid = UIDevice.current.identifierForVendor!.uuidString
    
    static let kEmail                           = "email"
    static let kPassword                        = "password"
    static let kName                            = "first_name"
    static let kLastname                        = "last_name"
    static let kFullname                        = "full_name"
    static let kPhoneNum                        = "phone_no"
    static let KAddress                        = "address"
    static let kProfilePic                     = "profile_pic"
    static let kDeviceToken                     = "device_token"
    static let kDeviceType                      = "device_type"
    static let kDeviceId                        = "deviceId"
    static let kSocialId                        = "socialId"
    static let kSocialType                      = "socialType"
    static let KAuthkey                         = "authKey"
    
    //Geet
    static let KOldPassword                        = "oldpassword"
    static let KNewPassword                        = "newpassword"
    
    static let auth = "Authorization"
    static let jwt = "JWT"
    static let tokenKey = "token="
    static let kStatus                          = "status"
    static let kMessage                         = "message"
    static let kData                            = "data"
    static let kToken                           = "token"

    // Filter
    static let filter = "filter"
    static let time = "time"
    static let dishtype = "dish_type"
    static let cuisine = "cuisine"
    
    //Add User info
    static let goals = "goals"
    static let diet_category = "goals"
    static let cooking_level = "cooking_level"
    static let allergies = "allergies"
    static let ingredients_donot_like = "ingredients_donot_like"
    static let cook_for_people = "cook_for_people"
    
    static let ingredients = "ingredients"


}

