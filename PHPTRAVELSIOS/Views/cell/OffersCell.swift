//
//  FoamCell.swift
//  memuDemo
//
//  Created by Qasim Hussain on 10/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class OffersCell: UITableViewCell {
    
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var offer_name: UILabel!
    @IBOutlet weak var imge: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

