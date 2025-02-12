//
//  HotelDetailsRequest.swift
//  memuDemo
//
//  Created by Qasim Hussain on 10/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import SVProgressHUD

class HotelDetailsRequest: NSObject {
    
    override init() {
        
    }
    
    
    func getCarHotelDetails(hotel_info : HotelInfo ,onCompletion:@escaping ([String],[NameImage],Overview,[NameImage],[Room_Model],[Review],Bool,String)->Void)
    {
        
        
        print("Deatis url = ","\(Constant.domain)hotels/hoteldetails?appKey=\(Constant.key)&id=\(hotel_info.id)&checkin=\(hotel_info.checkin)&checkout=\(hotel_info.checkout)&child=\(hotel_info.child)&adults=\(hotel_info.adult)")
        var imagesArray = [String]()
        var amenitiesArray = [NameImage]()
        var paymentsArray = [NameImage]()
        var roomArray = [Room_Model]()
        var reviewArray = [Review]()
        
        var overview : Overview? = Overview(id: "", desc: "", policy: "", latitude: "", longitude: "")
        
        
        NetworkManager.sharedInstance.requestGETURL("\(Constant.domain)hotels/hoteldetails?appKey=\(Constant.key)&id=\(hotel_info.id)&checkin=\(hotel_info.checkin)&checkout=\(hotel_info.checkout)&child=\(hotel_info.child)&adults=\(hotel_info.adult)", success: { (json) in
            
            
            
            var mainObject = json["response"]
            var hotelObject = mainObject["hotel"]
            
            
            
            overview = Overview(id: hotelObject["id"].stringValue, desc: hotelObject["desc"].stringValue, policy: hotelObject["policy"].stringValue, latitude: hotelObject["latitude"].stringValue, longitude: hotelObject["longitude"].stringValue)
            
            
            var imgSlider = hotelObject["sliderImages"]
            
            var amenities = hotelObject["amenities"]
            
            var payments_arr = hotelObject["paymentOptions"]
            
            var review_arr = mainObject["reviews"]
            
            
            
            let room_arr = mainObject["rooms"]
            
            
            for i in 0..<review_arr.count {
                
                let review_Object = Review(name: review_arr[i]["review_name"].stringValue, date: review_arr[i]["review_date"].stringValue, rating: review_arr[i]["review_overall"].stringValue, review_txt: review_arr[i]["review_comment"].stringValue)
                
                reviewArray.append(review_Object)
                
                
            }
            
            
            for i in 0..<room_arr.count{
                
                let room_Object = room_arr[i]
                
                let room = Room_Model(room_img_url: room_Object["Images"][0]["thumbImage"].stringValue,
                                      room_name: room_Object["title"].stringValue,
                                      room_id: room_Object["id"].stringValue,
                                      room_price: "\(room_Object["price"].stringValue) \(room_Object["currCode"].stringValue) For \(room_Object["Info"]["stay"].stringValue) Nights",
                    room_quantity: room_Object["maxQuantity"].stringValue, room_selected: "1")
                
                roomArray.append(room)
                
            }
            
            for i in 0..<payments_arr.count {
                
                let nM = NameImage(name:payments_arr[i]["name"].stringValue ,img:  "", UIimg: #imageLiteral(resourceName: "checked"))
                paymentsArray.append(nM)
            }
            
            
            
            for i in 0..<imgSlider.count{
                
                imagesArray.append(imgSlider[i]["thumbImage"].stringValue)
                
                
            }
            for i in 0..<amenities.count{
                
                
                let nM = NameImage(name:amenities[i]["name"].stringValue ,img:  amenities[i]["icon"].stringValue, UIimg: UIImage())
                amenitiesArray.append(nM)
                
            }
            onCompletion(imagesArray,amenitiesArray,overview!,paymentsArray,roomArray,reviewArray,false,"")
            
            SVProgressHUD.dismiss()
            
            
            
            
            
        }) { (error) in
            
            
            onCompletion(imagesArray,amenitiesArray,overview!,paymentsArray,roomArray,reviewArray,true,error.localizedDescription)
            
        }
    }
}

