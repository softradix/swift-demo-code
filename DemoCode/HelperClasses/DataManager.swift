//
//  DataManager.swift
//  Sorsr
//
//  Created by user on 10/04/20.
//  Copyright © 2020 aulakh. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    

    
    //Current user's id
    var UserID:String{
        get{
            return UserDefaults.standard.value(forKey: "Userid") as? String ?? ""
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: "Userid")
        }
    }
    
    var DeviceToken:String{
        get{
            return UserDefaults.standard.value(forKey: "DeviceToken") as? String ?? ""
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: "DeviceToken")
        }
    }

    
    
    var AuthToken:String{
        get{
            return UserDefaults.standard.value(forKey: "AuthToken") as? String ?? "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3N3YXRlLnNvZnRyYWRpeHRlY2hub2xvZ2llcy5jb20vYXBpL2F1dGgvbG9naW4iLCJpYXQiOjE2MTcyODM4OTEsIm5iZiI6MTYxNzI4Mzg5MSwianRpIjoiQUlnalRtTzh0bXE0VFZYbCIsInN1YiI6MTgwLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.bJQBvv4O0nIulOzu8YXFE_4I-5_UDFQdsAX9Agz7wdU"
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: "AuthToken")
        }
    }
    
    var UserName:String{
           get{
               return UserDefaults.standard.value(forKey: "UserName") as? String ?? ""
           }
           set{
               UserDefaults.standard.setValue(newValue, forKey: "UserName")
           }
       }
    
    var UserEmail:String{
              get{
                  return UserDefaults.standard.value(forKey: "UserEmail") as? String ?? ""
              }
              set{
                  UserDefaults.standard.setValue(newValue, forKey: "UserEmail")
              }
          }
    
    var TimeForExercise:String{
        get{
            return UserDefaults.standard.value(forKey: "exercise_time_in_minutes") as? String ?? "30"
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: "exercise_time_in_minutes")
        }
    }
    
    var Intensity:String{
        get{
            return UserDefaults.standard.value(forKey: "intensity") as? String ?? "easy"
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: "intensity")
        }
    }
    
    var HideCongratsPopUp:Bool{
           get{
               return UserDefaults.standard.value(forKey: "HideCongratsPopUp") as? Bool ?? false
           }
           set{
               UserDefaults.standard.setValue(newValue, forKey: "HideCongratsPopUp")
           }
       }
    
    
}
