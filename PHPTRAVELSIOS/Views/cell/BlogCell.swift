//
//  BlogCell.swift
//  memuDemo
//
//  Created by Qasim Hussain on 07/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class BlogCell: UITableViewCell {
    
    
    @IBOutlet weak var blog_img: UIImageView!
    
    @IBOutlet weak var blog_title: UILabel!
    
    @IBOutlet weak var blog_desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

