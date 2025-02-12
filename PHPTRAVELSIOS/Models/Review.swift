//
//  Review.swift
//  memuDemo
//
//  Created by Qasim Hussain on 19/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class Review: NSObject {
    
    var name : String = ""
    var date : String = ""
    var rating : String = ""
    var review_txt : String = ""

    
     init(name : String, date : String, rating : String , review_txt: String) {
        
        self.name = name
        self.date = date
        self.rating = rating
        self.review_txt = review_txt
    }
    

}
