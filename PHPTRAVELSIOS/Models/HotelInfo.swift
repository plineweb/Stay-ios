//
//  HotelInfo.swift
//  memuDemo
//
//  Created by APPLE on 03/07/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class HotelInfo: NSObject {
    
    var child : String = ""
    var adult : String = ""
    var checkin : String = ""
    var checkout : String = ""
    var id : String = ""
    
    

    init(id : String,child : String,adult : String ,checkin : String, checkout : String) {
    
        self.id =  id
        self.child =  child
        self.adult = adult
        self.checkin = checkin
        self.checkout = checkout
        
    }


}
