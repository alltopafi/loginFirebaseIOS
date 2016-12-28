//
//  User.swift
//  loginTestApp
//
//  Created by Jesse Alltop on 12/27/16.
//  Copyright © 2016 Jesse Alltop. All rights reserved.
//

import Foundation
import Firebase

class User {
    var username: String?
    var password: String?
    
    init(username: String, password: String){
        self.username = username
        self.password = password
    }
    
    
    func toAnyObject() -> AnyObject{
        
        let dictionary: [String:String] = [
            "username" : self.username!,
            "password" : self.password!
        ]
        return dictionary as AnyObject
    }
    
}
