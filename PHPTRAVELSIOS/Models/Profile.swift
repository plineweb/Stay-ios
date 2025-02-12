//
//  Profile.swift
//  memuDemo
//
//  Created by Qasim Hussain on 11/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class Profile: NSObject {
    
    var first_name : String = ""
    var last_name : String = ""
    var phone_number : String = ""
    var email : String = ""
    var password : String = ""
    var confirm_passwrod : String = ""
    var address : String = ""
    var address2 : String = ""
    var city : String = ""
    var postal_code : String = ""
    var state : String = ""
    var country : String = ""
    
    init(first_name : String, last_name : String , phone_number : String , email : String, password : String
        , confirm_passwrod : String , address : String,address2 : String, city : String, postal_code : String,state : String, country : String) {
        
        self.first_name  = first_name
        self.last_name = last_name
        self.phone_number = phone_number
        self.email = email
        self.password = password
        self.confirm_passwrod = confirm_passwrod
        self.address = address
        self.address2 = address2
        self.city = city
        self.postal_code = postal_code
        self.state = state
        self.country = country
        
    }


}
