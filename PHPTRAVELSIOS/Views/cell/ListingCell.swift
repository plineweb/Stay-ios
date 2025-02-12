//
//  ListingCellTableViewCell.swift
//  memuDemo
//
//  Created by APPLE on 04/07/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

protocol BookListingClick{
    func GoToListing(at index:IndexPath)
}
class ListingCell: UITableViewCell {
    
    @IBOutlet weak var loading_effect: SpinnerView!
    @IBOutlet weak var hotel_name: UILabel!
    var delegate:BookListingClick!
    var indexPath:IndexPath!
    @IBOutlet weak var ratingStars: FloatRatingView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func Book_Listing(_ sender: UIButton) {
        
        self.delegate?.GoToListing(at: indexPath)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

