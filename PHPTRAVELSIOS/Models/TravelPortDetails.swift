//
//  TravelPortDetails.swift
//  memuDemo
//
//  Created by Qasim Hussain on 29/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class TravelPortDetails: NSObject {
    
    var date_to : String = ""
    var date_from : String = ""
    var location_from : String = ""
    var location_to : String = ""
    var flight_type : String = ""
    var time_from : String = ""
    var time_to : String = ""

    var check_inner_segment = ""
    var check_header_segment  = ""
    var check_CheckUnChecked  = false
    var key : String = ""


    
     override init() {
        
    }
}
