//
//  HotelListing.swift
//  memuDemo
//
//  Created by APPLE on 04/07/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class HotelListing: NSObject {
    
    var Hotel_name : String = ""
    var Hotel_location : String = ""
    var Hotel_rating : String = ""
    var Hotel_star : String = ""
    var imageUrl : String = ""
    var Hotel_price : String = ""
    var Hotel_Id : String = ""
    
    init(h_name : String, h_location : String, h_ration : String , h_star : String, h_price : String , h_image : String , id : String ) {
        
        self.Hotel_name = h_name
        self.Hotel_location = h_location
        self.Hotel_rating = h_ration
        self.Hotel_price = h_price
        self.Hotel_star = h_star
        self.imageUrl = h_image
        self.Hotel_Id = id
        
        }

}
