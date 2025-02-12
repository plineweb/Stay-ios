//
//  ManualFlightDetialsCell.swift
//  PHPTRAVELSIOS
//
//  Created by Qasim Hussain on 6/23/18.
//  Copyright © 2018 Qasim Hussain. All rights reserved.
//

import UIKit

class ManualFlightDetialsCell: UITableViewCell {

    @IBOutlet weak var arrival_date: UILabel!
    @IBOutlet weak var departure_date: UILabel!
    @IBOutlet weak var to_locations: UILabel!
    @IBOutlet weak var from_locations: UILabel!
    @IBOutlet weak var departure_time: UILabel!
    @IBOutlet weak var arrival_time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
