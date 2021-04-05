//
//  LoginModel.swift
//  Recipes
//
//  Created by Softradix Mac Mini on 31/03/21.
//

import Foundation
import ObjectMapper

class LoginModel : Mappable {
    var id : Int?
    var allergies : [Allergie]?
    var cook_for_people : String?
    var cooking_level : [CookingLevels]?
    var diet_category : DietCategories?
    var email : String?
    var goals : [Goals]?
    var ingredients_donot_like :String?
    var last_name : String?
    var name: String?
    var type: String?
    var push_notification : String?
    var userImage : String?
    var donot_like : [IngredientsDonoLike]?
    var breakfast_time : String?
    var dinner_time : String?
    var lunch_time : String?
    var cooking_days : String?
    var userDontlike : [UserIngredientsDonoLike]?
    var userAllergies : [UserAllergies]?
    var units : [Units]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        allergies <- map["allergies"]
        cook_for_people <- map["cook_for_people"]
        cooking_level <- map["cooking_level"]
        diet_category <- map["diet_category"]
        goals <- map["goals"]
        ingredients_donot_like <- map["ingredients_donot_like"]
        last_name <- map["last_name"]
        type <- map["type"]
        push_notification <- map["push_notification"]
        userImage <- map["user_picture"]
        cooking_days <- map["cooking_days"]
        dinner_time <- map["dinner_time"]
        lunch_time <- map["lunch_time"]
        breakfast_time <- map["breakfast_time"]
        donot_like <- map["donot_like"]
        userDontlike <- map["donot_like"]
        userAllergies <- map["allergies"]
    }
    
    class var curentUser:LoginModel? {
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: "currentUser")
                currentUserExists = false
            }
            else {
                UserDefaults.standard.set(newValue?.toJSON(), forKey:"currentUser")
                currentUserExists = true
            }
            UserDefaults.standard.synchronize()
        }
        get {
            let dictUser = UserDefaults.standard.dictionary(forKey:"currentUser")
            if dictUser != nil {
                return Mapper<LoginModel>().map(JSON:(dictUser)!)!
            }
            return nil
        }
    }
    
    class var currentUserExists:Bool {
        set {}
        get {
            return UserDefaults.standard.dictionary(forKey:"currentUser") != nil
        }
    }
}
