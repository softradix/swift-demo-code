//
//  UserDataModel.swift
//  Recipes
//
//  Created by Softradix Mac Mini on 31/03/21.
//

import Foundation
import ObjectMapper

class UserDataModel : Mappable {
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
    
    class var curentUser:UserDataModel? {
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
                return Mapper<UserDataModel>().map(JSON:(dictUser)!)!
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

class DietCategories : Mappable {
    var id : Int?
    var created_at : String?
    var diet_category_description : String?
    var diet_category_name : String?
    
    init(id:Int, created_at:String, diet_category_description:String, diet_category_name:String) {
        self.id = id
        self.created_at = created_at
        self.diet_category_description = diet_category_description
        self.diet_category_name = diet_category_name
    }
    

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        created_at <- map["created_at"]
        diet_category_description <- map["diet_category_description"]
        diet_category_name <- map["diet_category_name"]

    }
    

  
}
class CookingLevels : Mappable {
    var id : Int?
    var description : String?
    var level_name : String?
    
    init(id:Int, description:String, level_name:String) {
        self.id = id
        self.description = description
        self.level_name = level_name
    }
    

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        description <- map["description"]
        level_name <- map["level_name"]

    }
    
  
}
class Goals : Mappable {
    var id : Int?
    var goal_name : String?
    
    init(id:Int, goal_name:String) {
        self.id = id
        self.goal_name = goal_name
    }
    

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        goal_name <- map["goal_name"]

    }
    
  
}

class IngredientCategories : Mappable {
    var id : Int?
    var created_at : String?
    var category_name : String?
    
    init(id:Int, created_at:String, category_name:String) {
        self.id = id
        self.created_at = created_at
        self.category_name = category_name
    }
    

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        created_at <- map["created_at"]
        category_name <- map["category_name"]

    }
    
}
class Allergie : Mappable {
    var id : Int?
    var description : String?
    var level_name : String?
    
    init(id:Int, description:String, level_name:String) {
        self.id = id
        self.description = description
        self.level_name = level_name
    }
    

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        description <- map["description"]
        level_name <- map["level_name"]

    }
    
  
}

class UserAllergies : Mappable {
    var id : Int?
    var item_image : String?
    var item_name : String?
    
    init(id:Int, description:String, level_name:String) {
        self.id = id
        self.item_image = description
        self.item_name = level_name
    }
    

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        item_image <- map["item_image"]
        item_name <- map["item_name"]

    }
    
  
}

class IngredientsDonoLike : Mappable {
    var id : Int?
    var description : String?
    var level_name : String?
    
    init(id:Int, description:String, level_name:String) {
        self.id = id
        self.description = description
        self.level_name = level_name
    }
    

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        description <- map["description"]
        level_name <- map["level_name"]

    }
    
  
}

class UserIngredientsDonoLike : Mappable {
    var id : Int?
    var item_image : String?
    var item_name : String?
    
    init(id:Int, description:String, level_name:String) {
        self.id = id
        self.item_image = description
        self.item_name = level_name
    }
    

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        item_image <- map["item_image"]
        item_name <- map["item_name"]

    }
    
  
}

class AddUserInfo : Mappable {
    var Userid : Int?
    var Goals : [Int]?
    var DietCategory : Int?
    var CookingLevel : Int?
    var Allergies : [Int]?
    var IngredientsDonotLike : [Int]?
    var CookForPeople : Int?
    
    init(id:Int, goals:[Int]?, dietCategory:Int?, cookinLevel : Int? , allergies : [Int]?, ingredientsDonoLike : [Int]?, cookForPeople : Int? ) {
        self.Userid = id
        self.Goals = goals
        self.DietCategory = dietCategory
        self.CookingLevel = cookinLevel
        self.Allergies = allergies
        self.IngredientsDonotLike = ingredientsDonoLike
        self.CookForPeople = cookForPeople
    }
    

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        Userid <- map["user_id"]
        Goals <- map["goals"]
        DietCategory <- map["diet_category"]
        self.CookingLevel <-  map["cooking_level"]
        self.Allergies <-  map["allergies"]
        self.IngredientsDonotLike <-  map["ingredients_donot_like"]
        self.CookForPeople <-  map["cook_for_people"]
    }
    
  
}
