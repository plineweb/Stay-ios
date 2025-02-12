//
//  TravelPortModel.swift
//  memuDemo
//
//  Created by Qasim Hussain on 25/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class TravelPortModel: NSObject {
    
    var aero_plane_number : String = ""
    var take_off_destination : String = ""
    var arrivalDestination : String = ""
    var total_time : String = ""
    var toatl_stop : String = ""
    var arrival_time : String = ""
    var takeOff_time : String = ""
    var name_aero : String = ""
    var price : String = ""
    var img_aero : String = ""
    var currCode : String = ""
    
    var b_inbound = false
    var b_takeOff_time : String = ""
    var b_arrival_time : String = ""
    var b_toatl_time : String = ""
    var b_takeOffDestination : String = ""
    var b_total_stop : String = ""
    var b_arrivalDestination : String = ""
    var b_aero_code : String = ""
    var checkInsert : Bool = false
    var detials : [TravelPortDetails] = []
    var detials_inbounds : [TravelPortDetails] = []




      override init() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   


}
