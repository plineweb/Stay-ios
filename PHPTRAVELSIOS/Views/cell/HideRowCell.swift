//
//  HideRowCell.swift
//  memuDemo
//
//  Created by Qasim Hussain on 29/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit


protocol RecivedSelectedArray{
    func UpdateRecData(at recivieData:[TravelPortDetails],inboundData : [TravelPortDetails])
}
class HideRowCell: UITableViewCell {
    
    
    @IBOutlet weak var out_bounds_tb: TP_Inbount!
    
    var details_delegate : RecivedSelectedArray!
    var recivieData : [TravelPortDetails]!
    var out_recivieData : [TravelPortDetails] = []
    
    
    
    @IBOutlet weak var inbounds_height: NSLayoutConstraint!
    
    @IBOutlet weak var tp_details_tb: travelport_detials!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func Continue_click(_ sender: UIButton) {
        
        details_delegate?.UpdateRecData(at : recivieData,inboundData: out_recivieData)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

