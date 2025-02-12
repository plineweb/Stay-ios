//
//  LoginModel.swift
//  memuDemo
//
//  Created by Qasim Hussain on 05/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import EVReflection
import SwiftyJSON

class LoginModel: NSObject {
    
    var check : Bool = false
    var email : String = ""
    var id : String = ""
    var msg : String = ""
    var name : String = ""
    var password : String = ""
    var myResponse : JSON = []


    
    init(check : Bool,email : String,id : String, msg : String , name : String) {
        
        self.check = check
        self.email = email
        self.id = id
        self.msg = msg
        self.name = name
        
    }
    
    init(data : String){
        
        self.myResponse=JSON(data)
        
        
        self.check = self.myResponse["check"].boolValue
        self.email = self.myResponse["email"].stringValue
        self.id = self.myResponse["id"].stringValue
        self.msg = self.myResponse["msg"].stringValue
        self.name = self.myResponse["name"].stringValue
        self.password = self.myResponse["password"].stringValue
        
        print("My email = \(self.myResponse)")
    }


}
