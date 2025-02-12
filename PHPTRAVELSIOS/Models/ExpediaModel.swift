//
//  ExpediaModel.swift
//  memuDemo
//
//  Created by Qasim Hussain on 20/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class ExpediaModel: NSObject {
    
    var child : String = ""
    var adult : String = ""
    var checkin : String = ""
    var checkout : String = ""
    var customerSessionId : String = ""
    var ratekey : String = ""
    var rateCode : String = ""
    var roomType : String = ""

    var id : String = ""
    
    
    init(id : String,child : String,adult : String ,checkin : String, checkout : String,customerSessionId : String, ratekey : String, rateCode : String,roomType : String  ) {
        
        self.id =  id
        self.child =  child
        self.adult = adult
        self.checkin = checkin
        self.checkout = checkout
        self.customerSessionId = customerSessionId
        self.ratekey = ratekey
        self.rateCode = rateCode
        self.roomType = roomType
        
    }
    
    
}
