//
//  RoomCell.swift
//  memuDemo
//
//  Created by Qasim Hussain on 17/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import APJTextPickerView

protocol BookDelegate{
    func buttonBook(at index:IndexPath)
}

class RoomCell: UITableViewCell {
    
    
    @IBOutlet weak var room_quantity: APJTextPickerView!
    
    var indexPath:IndexPath!
    
    var delegate:BookDelegate!
    @IBOutlet weak var room_book: UIButton!
    @IBOutlet weak var room_img: UIImageView!
    
    @IBOutlet weak var room_price: UILabel!
    @IBOutlet weak var room_name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func BookIt(_ sender: UIButton) {
        
        self.delegate?.buttonBook(at: indexPath)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}

