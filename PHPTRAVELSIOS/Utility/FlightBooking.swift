//
//  FlightBooking.swift
//  PHPTRAVELSIOS
//
//  Created by Qasim Hussain on 6/28/18.
//  Copyright © 2018 Qasim Hussain. All rights reserved.
//

import UIKit
import SVProgressHUD


class FlightBooking:  NSObject {
    
    override init() {
        
    }
    
    func FlightBooking(guest : String,profile : HotelInfo,flight_info : HotelInfo,coupon_id : String,id : String,cabin_class : TourInfo,itemId : String,onCompletion:@escaping ([String],String)->Void)
    {
        var pa :  [String:String] = [:]
        var type_check = ""
        if (flight_info.id) == "oneway"
        {
            type_check = "oneway"
        }else{
            type_check = "return"
            
        }
        if guest != "guest"{
            
            pa  = [
                "userId": id,
                "itemid": itemId,
                "couponid": coupon_id,
                "children": cabin_class.child,
                "adults":cabin_class.adults,
                "infant":cabin_class.infants,
                "from" : flight_info.child,
                "to" :  flight_info.adult,
                "type" :  type_check,
            ]
        }else{
            pa  = [
                "itemid": itemId,
                "couponid": coupon_id,
                "children": cabin_class.child,
                "adults":cabin_class.adults,
                "infant":cabin_class.infants,
                "from" : flight_info.child,
                "to" :  flight_info.adult,
                "firstname":profile.id,
                "lastname":profile.child,
                "email":profile.adult,
                "address":profile.checkout,
                "phone":profile.checkin,
                "type" :  type_check,

            ]
        }
        
        
        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Loading")
        
        var result_arr = [String]()
        
        NetworkManager.sharedInstance.requestPOSTURL("\(Constant.domain)flights/invoice?appKey=\(Constant.key)", params: pa, success: { (json) in
            
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

