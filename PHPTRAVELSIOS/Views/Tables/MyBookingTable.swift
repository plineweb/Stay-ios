//
//  MyBookingTable.swift
//  memuDemo
//
//  Created by Qasim Hussain on 12/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster
import SVProgressHUD

class MyBookingTable: UITableView,UITableViewDataSource,UITableViewDelegate  {
    
    
    
    var controler : MyBookingController? = nil
    
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
        
        let book : HotelListing = self.mainArray[indexPath.row]
        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Loading")
        NetworkManager.sharedInstance.requestGETURL("\(Constant.domain)invoice/info?appKey=\(Constant.key)&invoiceno=\(book.Hotel_Id)&invoicecode=\(book.imageUrl)", success: { (json) in
            
            var mainArray = json["response"]
            
            if mainArray["error"].stringValue == ""
            {
                let searchController  = self.controler?.mainstoryboard.instantiateViewController(withIdentifier: "webview") as! WebViewHomeController
                searchController.url = mainArray["url"].stringValue
                self.controler?.navigationController?.pushViewController(searchController, animated: true)
            }else{
                self.controler?.view.endEditing(true)
                Toast(text: mainArray["error"].stringValue).show()
            }
            SVProgressHUD.dismiss()
            
            
        }) { (error) in
            SVProgressHUD.dismiss()
            Toast.init(text: error.localizedDescription).show()
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.mainArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mybooking_cell", for: indexPath) as! MyBookingCell
        
        let hL : HotelListing = self.mainArray[indexPath.row]
        
        cell.title.text = hL.Hotel_name
        cell.price.text = hL.Hotel_price
        cell.checkin.text = hL.Hotel_rating
        cell.checkout.text = hL.Hotel_star
        
        
        let imgURL = URL(string:hL.Hotel_location)
        
        cell.img.sd_setShowActivityIndicatorView(true)
        cell.img.sd_setIndicatorStyle(.gray)
        
        
        
        cell.img.sd_setImage(with: imgURL)
        
        
        
        
        
        return cell
        
    }
}

