//
//  listing.swift
//  memuDemo
//
//  Created by APPLE on 14/07/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import SDWebImage

class listing: UITableView,UITableViewDataSource,UITableViewDelegate,BookListingClick  {
    
    
    
    
    var controler : HTC_ListingViewController? = nil
    
    var offset : Int = 1
    
    var mainArray:[HotelListing] = []{
        didSet{
            reloadData()
        }
    }
    
    
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate=self
        self.dataSource=self
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if controler?.check == "Hotels"{
            
            controler?.hotel_listing_date = self.mainArray[indexPath.row]
            controler?.performSegue(withIdentifier: "show_details", sender: self)
            
        }else if controler?.check == "Tours"{
            
            controler?.hotel_listing_date = self.mainArray[indexPath.row]
            controler?.performSegue(withIdentifier: "showToursDetails", sender: self)
        }else if controler?.check == "Cars"{
            
            controler?.hotel_listing_date = self.mainArray[indexPath.row]
            controler?.performSegue(withIdentifier: "showCarsDetails", sender: self)
        }
        
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.mainArray.count;
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == self{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                self.offset = self.offset + 1
                controler?.loadMore(offset: self.offset, checkEmpty: false)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listing_cell", for: indexPath) as! ListingCell
        
        let hL : HotelListing = self.mainArray[indexPath.row]
        
        cell.hotel_name.text = hL.Hotel_name
        cell.price.text = hL.Hotel_price
        cell.rating.text = hL.Hotel_rating
        cell.location.text = hL.Hotel_location
        
        cell.ratingStars.rating = Float(hL.Hotel_star)!
        
        cell.indexPath = indexPath
        cell.delegate = self
        
        let imgURL = URL(string:hL.imageUrl)
        
        cell.img.sd_setShowActivityIndicatorView(true)
        cell.img.sd_setIndicatorStyle(.gray)
        
        
        
        cell.img.sd_setImage(with: imgURL)
        
        
        
        
        
        return cell
        
    }
    
    func GoToListing(at index: IndexPath) {
        if controler?.check == "Hotels"{
            
            controler?.hotel_listing_date = self.mainArray[index.row]
            controler?.performSegue(withIdentifier: "show_details", sender: self)
            
        }else if controler?.check == "Tours"{
            
            controler?.hotel_listing_date = self.mainArray[index.row]
            controler?.performSegue(withIdentifier: "showToursDetails", sender: self)
        }else if controler?.check == "Cars"{
            
            controler?.hotel_listing_date = self.mainArray[index.row]
            controler?.performSegue(withIdentifier: "showCarsDetails", sender: self)
        }
        
    }
    
    
}

