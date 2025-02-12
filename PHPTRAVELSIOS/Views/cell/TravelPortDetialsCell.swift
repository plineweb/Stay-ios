//
//  TravelPortDetialsCell.swift
//  memuDemo
//
//  Created by Qasim Hussain on 01/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

protocol CheckUnCheckDelegate{
    func CheckUnCheckClick(at index:IndexPath)
}
class TravelPortDetialsCell: UITableViewCell {
    
    
    var indexPath:IndexPath!
    
    var delegate:CheckUnCheckDelegate!
    
    @IBOutlet weak var date: UITextField!
    
    @IBOutlet weak var time_to: UILabel!
    @IBOutlet weak var time_from: UILabel!
    @IBOutlet weak var location_to: UILabel!
    @IBOutlet weak var location_from: UILabel!
    @IBOutlet weak var date_from: UILabel!
    @IBOutlet weak var lcoation: UITextField!
    @IBOutlet weak var date_to: UILabel!
    
    @IBOutlet weak var time: UITextField!
    
    @IBOutlet weak var select_routes: UITextField!
    @IBOutlet weak var cabinClass: UITextField!
    @IBOutlet weak var checkUncheck: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func CheckUnCheck(_ sender: UIButton) {
        
        self.delegate?.CheckUnCheckClick(at: indexPath)
        
    }
    
}

