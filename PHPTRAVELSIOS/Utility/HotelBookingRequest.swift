//
//  HotelBookingRequest.swift
//  memuDemo
//
//  Created by Qasim Hussain on 11/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import SVProgressHUD

class HotelBookingRequest: NSObject {
    
    override init() {
        
    }
    
    
    func HotelBooking(guest : String,profile : HotelInfo,coupon_id : String,id : String,hotel_info : HotelInfo, roomOb : Room_Model,onCompletion:@escaping ([String],String)->Void)
    {
        var pa :  [String:String] = [:]
        
        
        if guest != "guest"{
            
            pa  = [
                "userId":id,
                "itemid":hotel_info.id,
                "roomscount":roomOb.room_selected,
                "subitemid":roomOb.room_id,
                "apicheckin":hotel_info.checkin,
                "apicheckout":hotel_info.checkout,
                "couponid":coupon_id,
                "btype":"hotels",
                "children":hotel_info.child,
                "adults":hotel_info.adult
            ]
        }else{
            
            pa  = [
                "itemid":hotel_info.id,
                "roomscount":roomOb.room_selected,
                "subitemid":roomOb.room_id,
                "apicheckin":hotel_info.checkin,
                "apicheckout":hotel_info.checkout,
                "couponid":coupon_id,
                "btype":"hotels",
                "children":hotel_info.child,
                "adults":hotel_info.adult,
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
        
        NetworkManager.sharedInstance.requestPOSTURL("\(Constant.domain)hotels/invoice?appKey=\(Constant.key)", params: pa, success: { (json) in
            
            
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

