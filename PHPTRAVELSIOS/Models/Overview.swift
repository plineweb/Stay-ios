//
//  Overview.swift
//  memuDemo
//
//  Created by APPLE on 05/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class Overview: NSObject {
    
    var desc : String = ""
    var id : String = ""

    var policy : String = ""
    var latitude : String = ""
    var longitude : String = ""
    
    init(id : String,desc : String , policy : String, latitude : String, longitude : String) {
        
        self.desc = desc
        self.id = id
        self.policy = policy
        self.latitude = latitude
        self.longitude = longitude
        //Olamba
        
    }

}
