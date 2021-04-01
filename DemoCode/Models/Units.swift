//
//  Units.swift
//  DemoCode
//
//  Created by apple on 01/04/21.
//

import Foundation
import ObjectMapper

class Units : Mappable {
    var id : Int?
    var unit : String?
  
    
    init(id:Int, unit:String) {
        self.id = id
        self.unit = unit
    }
    

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        unit <- map["unit"]

    }
    
  
}
