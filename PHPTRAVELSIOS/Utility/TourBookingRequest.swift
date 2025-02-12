//
//  TourBookingRequest.swift
//  memuDemo
//
//  Created by Qasim Hussain on 11/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import SVProgressHUD
class TourBookingRequest: NSObject {
    
    override init() {
        
    }
    
    func TourBookingLogin(guest : String,profile : HotelInfo,coupon_id : String,id : String,tour_info : TourInfo,onCompletion:@escaping ([String],String)->Void)
    {
        var pa :  [String:String] = [:]
        
        
        if guest != "guest"{
            
            pa  = [
                "userId": id,
                "itemid": tour_info.id,
                "tdate": tour_info.date,
                "couponid": coupon_id,
                "btype":"tours",
                "children": tour_info.child,
                "adults":tour_info.adults,
                "infant":tour_info.infants
            ]
        }else{
            pa  = [
                "itemid": tour_info.id,
                "tdate": tour_info.date,
                "couponid": coupon_id,
                "btype":"tours",
                "children": tour_info.child,
                "adults":tour_info.adults,
                "infant":tour_info.infants,
                "firstname":profile.id,
                "lastname":profile.child,
                "email":profile.adult,
                "address":profile.checkout,
                "phone":profile.checkin
            ]
        }
        
        
        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Loading")
        
        var result_arr = [String]()
        
        NetworkManager.sharedInstance.requestPOSTURL("\(Constant.domain)tours/invoice?appKey=\(Constant.key)", params: pa, success: { (json) in
            
            print("response \(json["response"])" )
            
            if json["response"]["error"].stringValue == "yes"{
                
                result_arr.append("yes")
                result_arr.append(json["response"]["msg"].stringValue)
                
            }else{
                
                result_arr.append("no")
                result_arr.append(json["response"]["url"].stringValue)
            }
            
            onCompletion(result_arr,"")
            
        }) { (error) in
            
            onCompletion(result_arr,error.localizedDescription)
            
        }
    }
    
}

