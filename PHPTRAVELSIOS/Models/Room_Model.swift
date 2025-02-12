//
//  Room_Model.swift
//  memuDemo
//
//  Created by Qasim Hussain on 17/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class Room_Model: NSObject {
    
    var room_img_url : String = ""
    var room_name : String = ""
    var room_id : String = ""
    var room_price : String = ""
    var room_quantity : String = ""
    var room_selected : String = ""
    
    init(room_img_url : String, room_name: String, room_id : String,room_price : String, room_quantity : String,room_selected : String) {
        
        self.room_img_url = room_img_url
        self.room_name = room_name
        self.room_id = room_id
        self.room_price = room_price
        self.room_quantity = room_quantity
        self.room_selected = room_selected
        
        
    }

    

}
