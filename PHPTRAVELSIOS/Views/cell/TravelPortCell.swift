//
//  TravelPortCell.swift
//  memuDemo
//
//  Created by Qasim Hussain on 26/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class TravelPortCell: UITableViewCell {
    
    @IBOutlet weak var details_cell: CardView!
    @IBOutlet weak var b_takeOff_time: UILabel!
    @IBOutlet weak var b_arrival_time: UILabel!
    
    @IBOutlet weak var b_total_time: UILabel!
    @IBOutlet weak var b_takeOffDestination: UILabel!
    
    @IBOutlet weak var b_total_stop: UILabel!
    
    @IBOutlet weak var b_arrivalDestination: UILabel!
    
    @IBOutlet weak var b_aero_code: UILabel!
    
    @IBOutlet weak var aero_plane_number: UILabel!
    @IBOutlet weak var take_off_destination: UILabel!
    @IBOutlet weak var toatl_stop: UILabel!
    @IBOutlet weak var arrivalDestination: UILabel!
    @IBOutlet weak var total_time: UILabel!
    @IBOutlet weak var arrival_time: UILabel!
    @IBOutlet weak var takeOff_time: UILabel!
    @IBOutlet weak var name_aero: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var img_aero: UIImageView!
    @IBOutlet weak var currCode: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let selectedBackgroundView = UIView();
        selectedBackgroundView.backgroundColor = .white
        self.selectedBackgroundView = selectedBackgroundView
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

