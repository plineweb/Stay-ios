//
//  Tp_checkout_details.swift
//  memuDemo
//
//  Created by Qasim Hussain on 06/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class Tp_checkout_details: UITableViewCell {
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var class_type: UILabel!
    @IBOutlet weak var flight_number: UILabel!
    @IBOutlet weak var location_to: UILabel!
    @IBOutlet weak var location_from: UILabel!
    @IBOutlet weak var company_name: UILabel!
    @IBOutlet weak var time_to: UILabel!
    @IBOutlet weak var time_from: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

