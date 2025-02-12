//
//  MyBookingCell.swift
//  memuDemo
//
//  Created by Qasim Hussain on 12/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class MyBookingCell: UITableViewCell {
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var checkout: UILabel!
    @IBOutlet weak var checkin: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

