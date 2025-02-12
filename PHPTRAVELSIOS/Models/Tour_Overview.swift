//
//  Tour_Overview.swift
//  memuDemo
//
//  Created by Qasim Hussain on 22/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class Tour_Overview: NSObject {
    
    
    
    
    var perAdultPrice : String = ""
    var perChildPrice : String = ""
    var perInfantPrice : String = ""
    var adultStatus : String = ""
    var childStatus : String = ""
    var infantStatus : String = ""
    var adultPrice : String = ""
    var childPrice : String = ""
    var infantPrice : String = ""
    var maxAdults : String = ""
    var maxChild : String = ""
    var maxInfant : String = ""
    var desc : String = ""
    var policy : String = ""
    var currSumbol : String = ""



    
    init(perAdultPrice : String,perChildPrice : String,perInfantPrice : String
              ,adultStatus : String,childStatus : String,infantStatus : String
              ,adultPrice : String,childPrice : String,infantPrice : String,
               maxAdults : String,maxChild : String,maxInfant : String,
                desc : String,policy : String,currSumbol : String) {
      
        self.perAdultPrice = perAdultPrice
        self.perChildPrice = perChildPrice
        self.perInfantPrice = perInfantPrice
        self.adultStatus = adultStatus
        self.childStatus = childStatus
        self.infantStatus = infantStatus
        self.adultPrice = adultPrice
        self.childPrice = childPrice
        self.infantPrice = infantPrice
        self.maxAdults = maxAdults
        self.maxChild = maxChild
        self.maxInfant = maxInfant
        self.desc = desc
        self.policy = policy
        self.currSumbol = currSumbol

    }

}
