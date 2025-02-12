//
//  ExpediaListing.swift
//  memuDemo
//
//  Created by Qasim Hussain on 21/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class ExpediaListing: NSObject {
    
    var Hotel_name : String = ""
    var Hotel_location : String = ""
    var Hotel_star : String = ""
    var imageUrl : String = ""
    var Hotel_price : String = ""
    var Hotel_Id : String = ""
    var ratekey : String = ""
    var rateCode : String = ""
    var roomType : String = ""
    
    init(h_name : String, h_location : String, h_star : String, h_price : String , h_image : String , id : String, ratekey : String, rateCode : String,roomType : String  ) {
        
        self.Hotel_name = h_name
        self.Hotel_location = h_location
        self.Hotel_price = h_price
        self.Hotel_star = h_star
        self.imageUrl = h_image
        self.Hotel_Id = id
        self.ratekey = ratekey
        self.rateCode = rateCode
        self.roomType = roomType
        
    }
    
}
