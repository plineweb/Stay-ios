//
//  HTC_ListingViewController.swift
//  memuDemo
//
//  Created by APPLE on 04/07/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD
import Toaster

class HTC_ListingViewController: UIViewController {

    var mainArray:[HotelListing] = []
    
    @IBOutlet weak var load_more: UIView!
    @IBOutlet weak var list: listing!
    
    var hotel_search_date : HotelInfo? = nil
    var expedia_info : ExpediaModel? = nil

    var hotel_listing_date : HotelListing? = nil
    var tour_search_data : TourInfo? = nil
    var car_search_data : CarInfo? = nil
    var check : String = ""
    var url : String = ""
    var  totalOffset : Int = 1
    
    var checkMoreEan  = true


    var reviewArray = [Review]()
    var imagesArray = [String]()
    var amenitiesArray = [NameImage]()
    var paymentsArray = [NameImage]()
    var roomArray = [Room_Model]()
    var overview : Overview? = Overview(id: "", desc: "", policy: "", latitude: "", longitude: "")

    
    override func viewDidAppear(_ animated: Bool) {
        self.load_more.isHidden = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.white

        
        if check == "Hotels"{
            if (hotel_search_date?.id)!=="0"{
             self.url = "\(Constant.domain)hotels/list?appKey=\(Constant.key)&checkin=\((hotel_search_date?.checkin)!)&checkout=\((hotel_search_date?.checkout)!)&child=\((hotel_search_date?.child)!)&adults=\((hotel_search_date?.adult)!)"
            }
            else{
             self.url = "\(Constant.domain)hotels/search?appKey=\(Constant.key)&searching=\((hotel_search_date?.id)!)&checkin=\((hotel_search_date?.checkin)!)&checkout=\((hotel_search_date?.checkout)!)&child=\((hotel_search_date?.child)!)&adults=\((hotel_search_date?.adult)!)"
            }
            self.loadMore(offset: 1,checkEmpty: true)
            
        }else if check == "expedia"{
            if (hotel_search_date?.id)!==""{
                self.url = "\(Constant.domain)expedia/list?appKey=\(Constant.key)&checkin=\((hotel_search_date?.checkin)!)&checkout=\((hotel_search_date?.checkout)!)&child=\((hotel_search_date?.child)!)&adults=\((hotel_search_date?.adult)!)"
            }
            else{
                let locations : String = (hotel_search_date?.id.replacingOccurrences(of: " ", with: ","))!
                 let loc = locations.components(separatedBy: ",")
                self.url = "\(Constant.domain)expedia/search?appKey=\(Constant.key)&location==\((loc[0]))&checkin=\((hotel_search_date?.checkin)!)&checkout=\((hotel_search_date?.checkout)!)&child=\((hotel_search_date?.child)!)&adults=\((hotel_search_date?.adult)!)"
            }
            self.loadMore(offset: 1,checkEmpty: true)
            
        }else if check == "Tours"{
        
            if (tour_search_data?.id)!=="0"{
                self.url = "\(Constant.domain)tours/list?appKey=\(Constant.key)&date=\((tour_search_data?.date)!)&adults=\((tour_search_data?.adults)!)&type=\((tour_search_data?.type)!)"
            }
            else{
                  self.url = "\(Constant.domain)tours/search?appKey=\(Constant.key)&id=\((tour_search_data?.id)!)&date=\((tour_search_data?.date)!)&adults=\((tour_search_data?.adults)!)&type=\((tour_search_data?.type)!)"
            }
            self.loadMore(offset: 1,checkEmpty: true)

        }else if check == "Cars"{
            
            if (car_search_data?.id_from)!=="0"{
                self.url = "\(Constant.domain)cars/list?appKey=\(Constant.key)&pickupDate=\((car_search_data?.checkin)!)&dropoffDate=\((car_search_data?.checkout)!)&pickupTime=\((car_search_data?.check_in_time)!)&dropoffTime=\((car_search_data?.check_to_time)!)"
            }
            else{
                self.url = "\(Constant.domain)cars/search?appKey=\(Constant.key)&pickupDate=\((car_search_data?.checkin)!)&dropoffDate=\((car_search_data?.checkout)!)&pickupTime=\((car_search_data?.check_in_time)!)&dropoffTime=\((car_search_data?.check_to_time)!)&pickupLocation=\((car_search_data?.id_from)!)&dropoffLocation=\((car_search_data?.id_to)!)"
            }
            self.loadMore(offset: 1,checkEmpty: true)

        }
    }
    
    

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
    }
    
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if check == "Hotels"{
        
            let hotel_details = segue.destination as! HotelDetailsViewController
            self.hotel_search_date?.id = (self.hotel_listing_date?.Hotel_Id)!
            hotel_details.hotel_info = self.hotel_search_date
            
        }else if check == "Cars"{
            
            let searching = segue.destination as! CarDetailsReq
            self.car_search_data?.id = (self.hotel_listing_date?.Hotel_Id)!
            searching.car_info = self.car_search_data
        }else if check == "Tours"{
        
            let searching = segue.destination as! TourDetailsReq
            self.tour_search_data?.id = (self.hotel_listing_date?.Hotel_Id)!
            searching.tuor_info = self.tour_search_data
        }
    }
    
 
    func loadMore(offset : Int, checkEmpty : Bool){
        
      
        
        if self.totalOffset >= offset{
            
            if offset != 1 {
                
                self.load_more.isHidden = false
            }else{
                
                SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
                SVProgressHUD.setForegroundColor(.white)
                SVProgressHUD.show(withStatus: "Loading")
                
            }
            
            NetworkManager.sharedInstance.requestGETURL(self.url, success: { (json) in
                
                self.totalOffset = json["totalPages"].intValue
                
                var mainArray = json["response"]
                
                if mainArray.count == 0{
                    
                    Toast.init(text: "No Result Avilable Change Your Query").show()
                    _ = self.navigationController?.popViewController(animated: true)
                }
                
                for index in 0..<mainArray.count{
                    
                    var indexObject = mainArray[index]
                    let h_name = indexObject["title"].stringValue
                    let h_id = indexObject["id"].stringValue
                    
                    let h_location = indexObject["location"].stringValue
                    let h_ration = "Ratings : \(indexObject["avgReviews"]["overall"])/10"
                    let h_star = indexObject["starsCount"].stringValue
                    let h_price = "\(indexObject["price"].stringValue) \(indexObject["currCode"])"
                    let h_image = indexObject["thumbnail"].stringValue
                    
                    let a = HotelListing(h_name: h_name, h_location: h_location, h_ration: h_ration, h_star: h_star, h_price: h_price, h_image: h_image, id: h_id)
                    self.mainArray.append(a)
                }
                self.list.controler = self
                self.load_more.isHidden = true
                self.list.mainArray = self.mainArray
            }) { (error) in
                
                Toast.init(text: error.localizedDescription).show()
            }

            
            
            
        }
        
    }

    func ExpedialoadMore(checkEmpty : Bool,checkFirst : Bool){
        
     
        
        
    }
    
    

}
