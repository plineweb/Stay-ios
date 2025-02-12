//
//  OffersTable.swift
//  memuDemo
//
//  Created by Qasim Hussain on 10/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class OffersTable:UITableView,UITableViewDelegate,UITableViewDataSource {
    
    var controller : OffersList? = nil
    
    
    var HotelsObject:[HotelListing] = []{
        didSet{
            reloadData()
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate=self
        self.dataSource=self
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        controller?.offerObject = self.HotelsObject[indexPath.row]
        controller?.performSegue(withIdentifier: "show_offers_details", sender: self)
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return HotelsObject.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "offers_cell", for: indexPath) as! OffersCell
        
        
        let offer : HotelListing = self.HotelsObject[indexPath.row]
        
        
        cell.offer_name.text = offer.Hotel_name
        cell.price.text = offer.Hotel_price
        cell.desc.text = offer.Hotel_rating
        
        
        
        let imgURL = URL(string:offer.imageUrl)
        
        cell.imge.sd_setShowActivityIndicatorView(true)
        cell.imge.sd_setIndicatorStyle(.gray)
        
        cell.imge.sd_setImage(with: imgURL)
        
        return cell
        
    }
    
    
    
    
}

