//
//  ServiceContants.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 28/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
let baseUrl = ""
struct Path {
    
    var registration: String { return "\(baseUrl)/registration" }
    
    var login: String { return "\(baseUrl)/login" }
    
    var forgotPassword: String { return "\(baseUrl)/forgotPassword" }
    
    var logout: String { return "\(baseUrl)/logout" }
    
    struct User {
        
        var getProfile: String { return "\(baseUrl)/profile" }
        
        var deleteUser: (Int) -> String = { userID in
            return "\(baseUrl)/profile/\(String(userID))"
        }
        
        struct Task {
            
            var getTasks: String { return "\(baseUrl)/tasks" }
            
            var getTaskDetail: (Int, Int) -> String = { userID, taskID in
                return "\(baseUrl)/profile/\(String(userID))/task/\(String(taskID))"
            }
            
        }
    }
}
