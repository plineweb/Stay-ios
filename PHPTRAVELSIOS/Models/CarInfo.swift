//
//  HotelInfo.swift
//  memuDemo
//
//  Created by APPLE on 03/07/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class CarInfo: NSObject {
    
    var checkin : String = ""
    var checkout : String = ""
    var id_from : String = ""
    var id_to : String = ""
    var id : String = ""
    var total_cast : String = ""
    var total_Deposite : String = ""
    var total_TaxPrice : String = ""



    var check_in_time : String = ""
    var check_to_time : String = ""

    
    init(id_from : String,id_to : String,checkin : String, checkout : String,check_in_time : String, check_to_time : String) {
        
        self.id_from =  id_from
        self.id_to = id_to
        self.checkin = checkin
        self.checkout = checkout
        self.check_in_time = check_in_time
        self.check_to_time = check_to_time
        
    }
    
    
}
