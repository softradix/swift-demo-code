//
//  RequestParameters.swift
//  Grrind Fitness
//
//  Created by Simranjeet Aulakh on 09/05/20.
//  Copyright © 2020 aulakh. All rights reserved.
//

import Foundation


struct HttpMethods {
    static let post = "POST"
    static let get = "GET"
}

enum Login {
    struct request {
        var email:String?
        var password:String?
    }
}

enum Register {
    struct request {
        var firstname:String?
        var lastname:String?
        var email:String?
        var password:String?
        var country:String? = "none"
        var city:String? = "none"
        var dob:String?
        var gender:String?
        var weight:String?
        var height:String?
        var days_per_week_for_exercise:String?
        var exercise_time_in_minutes:String?
    }
}

enum FrogotPassword {
    struct request {
        var email:String?
    }
}

