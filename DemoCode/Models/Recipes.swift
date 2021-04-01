//
//  Recipes.swift
//  DemoCode
//
//  Created by apple on 01/04/21.
//

import Foundation
import ObjectMapper

class Recipes : Mappable{
    var cooking_time : String?
    var cuisine : String?
    var diet : String?
    var directions : String?
    var dish : String?
    var receipe_id : Int?
    var receipe_image : String?
    var receipe_name : String?
    var ingrdeinets : [Ingredients]?
    var is_favourite : Bool?
    var user_quantity : String?
    var currentServing : Int?
    var totalAvailablCount : Int?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        receipe_id <- map["receipe_id"]
        cooking_time <- map["cooking_time"]
        cuisine <- map["cuisine"]
        diet <- map["diet"]
        directions <- map["directions"]
        dish <- map["dish"]
        receipe_id <- map["receipe_id"]
        receipe_image <- map["receipe_image"]
        receipe_name <- map["receipe_name"]
        ingrdeinets <- map["ingredients"]
        is_favourite <- map["is_favourite"]
        user_quantity <- map["user_quantity"]
        currentServing  <- map["currentServing"]
        totalAvailablCount  <- map["totalAvailablCount"]
        
      


    }
    
  
}

class Ingredients : Mappable {
    var ingredient_id : Int?
    var quantity : String?
    var unit : Units?
    var ingredient_description : String?
    var ingredient_name : String?
    var ingredient_storage_type : [IngredientStorageType]?
    var is_available : Bool?
    var user_quantity : String?


    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        ingredient_id <- map["ingredient_id"]
        quantity <- map["quantity"]
        unit <- map["unit"]
        ingredient_description <- map["ingredient_description"]
        ingredient_name <- map["ingredient_name"]
        ingredient_storage_type <- map["ingredient_storage_type"]
        is_available <- map["is_available"]
        user_quantity <- map["user_quantity"]
        
        
    }
    
  
}
extension Ingredients: Equatable { }
func ==(lhs: Ingredients, rhs: Ingredients) -> Bool {
    return lhs === rhs // === returns true when both references point to the same object
}
class IngredientStorageType : Mappable {
    var expire_days : String?
    var id : Int?
    var item_id : Int?
    var storage_type : StorageType?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        expire_days <- map["expire_days"]
        id <- map["id"]
        item_id <- map["unit"]
        storage_type <- map["storage_type"]
        
    }
    
  
}

class StorageType : Mappable {
    var id : Int?
    var storage_name : String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        storage_name <- map["storage_name"]
        id <- map["id"]
       
    }
    
  
}
