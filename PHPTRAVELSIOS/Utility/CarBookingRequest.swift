//
//  CarBookingRequest.swift
//  memuDemo
//
//  Created by Qasim Hussain on 11/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import SVProgressHUD

class CarBookingRequest: NSObject {
    
    override init() {
        
    }
    func CarBooking(guest : String,profile : HotelInfo,coupon_id : String,id : String,car_info : CarInfo,onCompletion:@escaping ([String],String)->Void)
    {
        var pa :  [String:String] = [:]
        
        
        if guest != "guest"{
            
            pa  = [
                "userId":id,
                "itemid":car_info.id,
                "pickuplocation":car_info.id_from,
                "dropofflocation":car_info.id_to,
                "pickupDate":car_info.checkin,
                "dropoffDate":car_info.checkout,
                "couponid":coupon_id,
                "btype":"cars",
                "pickupTime":car_info.check_in_time,
                "dropoffTime":car_info.check_to_time
            ]
        }else{
            
            pa  = [
                "itemid":car_info.id,
                "pickuplocation":car_info.id_from,
                "dropofflocation":car_info.id_to,
                "pickupDate":car_info.checkin,
                "dropoffDate":car_info.checkout,
                "couponid":coupon_id,
                "btype":"cars",
                "pickupTime":car_info.check_in_time,
                "dropoffTime":car_info.check_to_time,
                "firstname":profile.id,
                "lastname":profile.child,
                "email":profile.adult,
                "address":profile.checkout,
                "phone":profile.checkin,
            ]
            
        }
        
        
        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Loading")
        
        var result_arr = [String]()
        
        
        
        NetworkManager.sharedInstance.requestPOSTURL("\(Constant.domain)cars/invoice?appKey=\(Constant.key)", params: pa, success: { (json) in
            
            
            if json["response"]["error"].stringValue == "yes"{
                
                result_arr.append("yes")
                result_arr.append(json["response"]["msg"].stringValue)
                
            }else{
                
                result_arr.append("no")
                result_arr.append(json["response"]["url"].stringValue)
            }
            
            SVProgressHUD.dismiss()
            onCompletion(result_arr,"")
            
        }) { (error) in
            
            onCompletion(result_arr,error.localizedDescription)
        }
    }
}

