//
//  CarRequest.swift
//  memuDemo
//
//  Created by Qasim Hussain on 11/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import SVProgressHUD

class CarRequest:  NSObject {
    
    
    override init() {
        
    }
    
    func getCarDetails(car_info : CarInfo ,onCompletion:@escaping ([String],Overview,[NameImage],[AutoCompleteM],[AutoCompleteM],CarInfo,String)->Void)
    {
        
        var imagesArray = [String]()
        var paymentsArray = [NameImage]()
        var pickupArray = [AutoCompleteM]()
        var dropoffArray = [AutoCompleteM]()
        
        
        SVProgressHUD.show()
        
        var overview : Overview? = Overview(id: "", desc: "", policy: "", latitude: "", longitude: "")
        
        
        
        print("Deatis url = ","\(Constant.domain)cars/details?appKey=\(Constant.key)&id=\((car_info.id))&pickupLocation=\((car_info.id_from))&dropoffLocation=\((car_info.id_to))&pickupDate=\((car_info.checkin))&dropoffDate=\((car_info.checkout))&pickupTime=\(car_info.check_in_time)&dropoffTime=\(car_info.check_to_time)")
        
        
        
        NetworkManager.sharedInstance.requestGETURL("\(Constant.domain)cars/details?appKey=\(Constant.key)&id=\((car_info.id))&pickupLocation=\((car_info.id_from))&dropoffLocation=\((car_info.id_to))&pickupDate=\((car_info.checkin))&dropoffDate=\((car_info.checkout))&pickupTime=\(car_info.check_in_time)&dropoffTime=\(car_info.check_to_time)", success: { (json) in
            
            
            var mainObject = json["response"]
            var carObject = mainObject["car"]
            
            
            car_info.total_cast = "\(carObject["currCode"])  \(carObject["totalCost"])"
            
            car_info.total_Deposite = "\(carObject["currCode"])  \(carObject["totalDeposit"])"
            
            car_info.total_TaxPrice = "\(carObject["currCode"])  \(carObject["taxValue"])"
            
            
            
            if carObject["pickupLocation"].stringValue != "false"{
                
                overview = Overview(id: carObject["id"].stringValue, desc: carObject["desc"].stringValue, policy: carObject["policy"].stringValue, latitude: carObject["latitude"].stringValue, longitude: carObject["longitude"].stringValue)
                
                
                var imgSlider = carObject["sliderImages"]
                
                var payments_arr = carObject["paymentOptions"]
                
                var pickup_arr = carObject["pickupLocationList"]
                var dropoff_arr = carObject["dropoffLocationList"]
                print("And The Name is \(dropoff_arr.count)")
                
                
                
                for i in 0..<payments_arr.count {
                    
                    let nM = NameImage(name:payments_arr[i]["name"].stringValue ,img:  "", UIimg: #imageLiteral(resourceName: "checked"))
                    paymentsArray.append(nM)
                }
                
                
                
                for i in 0..<imgSlider.count{
                    
                    imagesArray.append(imgSlider[i]["thumbImage"].stringValue)
                }
                
                for i in 0..<dropoff_arr.count{
                    
                    dropoffArray.append(AutoCompleteM(name: dropoff_arr[i]["name"].stringValue,type : "",id : dropoff_arr[i]["id"].stringValue))
                    
                }
                
                for i in 0..<pickup_arr.count{
                    
                    pickupArray.append(AutoCompleteM(name: pickup_arr[i]["name"].stringValue,type : "",id : pickup_arr[i]["id"].stringValue))
                }
                
                
                
            }
            onCompletion(imagesArray,overview!,paymentsArray,pickupArray,dropoffArray,car_info,"")
            
            SVProgressHUD.dismiss()
            
            
        }) { (error) in
            
            onCompletion(imagesArray,overview!,paymentsArray,pickupArray,dropoffArray,car_info,error.localizedDescription)
            
        }
    }
    
}



