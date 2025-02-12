//
//  TourDetailsRequest.swift
//  memuDemo
//
//  Created by Qasim Hussain on 11/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster
import SVProgressHUD

class TourDetailsRequest: NSObject {
    
    
    override init() {
        
    }
    
    func getTourDetails(tourInfo : TourInfo ,onCompletion:@escaping ([String],[NameImage],[NameImage],Tour_Overview,[NameImage],[Review],String)->Void)
    {
        
        var imagesArray = [String]()
        var InclusionsArray = [NameImage]()
        var ExclusionsArray = [NameImage]()
        var paymentsArray = [NameImage]()
        
        var reviewArray = [Review]()
        
        
        
        SVProgressHUD.show()
        
        var overview : Tour_Overview? = Tour_Overview(perAdultPrice : "",perChildPrice : "",perInfantPrice : ""
            ,adultStatus : "",childStatus : "",infantStatus : ""
            ,adultPrice : "",childPrice : "",infantPrice : "",
             maxAdults : "",maxChild : "",maxInfant : "", desc: "", policy: "", currSumbol: "")
        
        print("Deatis url = ","\(Constant.domain)tours/details?appKey=\(Constant.key)&id=\(tourInfo.id)&date=\(tourInfo.date)&adults=\(tourInfo.adults)")
        
        
        NetworkManager.sharedInstance.requestGETURL("\(Constant.domain)tours/details?appKey=\(Constant.key)&id=\(tourInfo.id)&date=\(tourInfo.date)&adults=\(tourInfo.adults)", success: { (json) in
            
            var mainObject = json["response"]
            var TourObject = mainObject["tour"]
            
            overview = Tour_Overview(
                perAdultPrice : TourObject["perAdultPrice"].stringValue,
                perChildPrice : TourObject["perChildPrice"].stringValue,
                perInfantPrice : TourObject["perInfantPrice"].stringValue,
                adultStatus : TourObject["adultStatus"].stringValue,
                childStatus : TourObject["childStatus"].stringValue,
                infantStatus : TourObject["infantStatus"].stringValue,
                adultPrice : TourObject["adultPrice"].stringValue,
                childPrice : TourObject["childPrice"].stringValue,
                infantPrice : TourObject["infantPrice"].stringValue,
                maxAdults : TourObject["maxAdults"].stringValue,
                maxChild : TourObject["maxChild"].stringValue,
                maxInfant : TourObject["maxInfant"].stringValue,
                desc: TourObject["desc"].stringValue,
                policy: TourObject["policy"].stringValue,
                currSumbol: TourObject["currSymbol"].stringValue)
            
            
            var imgSlider = TourObject["sliderImages"]
            
            var inclusions = TourObject["inclusions"]
            var exclusions = TourObject["exclusions"]
            
            
            var payments = TourObject["paymentOptions"]
            
            var review_arr = mainObject["reviews"]
            
            for i in 0..<review_arr.count {
                
                let review_Object = Review(name: review_arr[i]["review_by"].stringValue, date: review_arr[i]["review_date"].stringValue, rating: review_arr[i]["rating"].stringValue, review_txt: review_arr[i]["review_comment"].stringValue)
                
                
                reviewArray.append(review_Object)
                
                
            }
            
            
            for i in 0..<inclusions.count {
                
                let nM = NameImage(name:inclusions[i]["name"].stringValue ,img:  "", UIimg: #imageLiteral(resourceName: "checked"))
                InclusionsArray.append(nM)
                
            }
            
            for i in 0..<exclusions.count {
                
                let nM = NameImage(name:exclusions[i]["name"].stringValue ,img:  "", UIimg: #imageLiteral(resourceName: "checked"))
                ExclusionsArray.append(nM)
                
            }
            
            for i in 0..<imgSlider.count{
                
                imagesArray.append(imgSlider[i]["thumbImage"].stringValue)
                
            }
            for i in 0..<payments.count {
                
                let nM = NameImage(name:payments[i]["name"].stringValue ,img:  "", UIimg: #imageLiteral(resourceName: "checked"))
                paymentsArray.append(nM)
            }
            
            onCompletion(imagesArray,InclusionsArray,ExclusionsArray,overview!,paymentsArray,reviewArray,"")
            
            SVProgressHUD.dismiss()
            
            
            
        }) { (error) in
            
            onCompletion(imagesArray,InclusionsArray,ExclusionsArray,overview!,paymentsArray,reviewArray,error.localizedDescription)
        }
    }
    
}

