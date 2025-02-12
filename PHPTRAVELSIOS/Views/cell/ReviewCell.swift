//
//  ReviewCell.swift
//  memuDemo
//
//  Created by Qasim Hussain on 19/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    @IBOutlet weak var card_view: CardView!
    @IBOutlet weak var Review_text: UILabel!
    @IBOutlet weak var Review_date: UILabel!
    @IBOutlet weak var Review_rating: UILabel!
    @IBOutlet weak var Review_Name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

