//
//  AutoCompleteM.swift
//  memuDemo
//
//  Created by APPLE on 02/07/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class AutoCompleteM: NSObject {
    
    var  name : String = ""
    var  type : String = ""
    var  id : String = ""
    
    init(name:String,type:String,id:String) {
        self.name = name
        self.type = type
        self.id = id
    }
}
