//
//  NameImage.swift
//  memuDemo
//
//  Created by APPLE on 05/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class NameImage: NSObject {
    
    var name : String = ""
    var img : String = ""
    var UIimg : UIImage? = nil
    
    
    
    init(name : String ,img:String,UIimg : UIImage) {
        self.name = name
        self.img = img
        self.UIimg = UIimg
        
        
    }
    

}
