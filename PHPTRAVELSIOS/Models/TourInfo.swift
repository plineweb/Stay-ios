//
//  TourInfo.swift
//  memuDemo
//
//  Created by APPLE on 08/07/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class TourInfo {

    
    var id : String = ""
    var location : String = ""
    var date : String = ""
    var adults : String = ""
    var type : String = ""
    var infants : String = ""
    var child : String = ""

    
    init(id : String,location: String, date: String,adults: String,type: String,child : String,infants : String) {
        
        self.id = id;
        self.location = location;
        self.date = date;
        self.adults = adults;
        self.type = type;
        self.infants = infants
        self.child = child
        
    }


    
}
