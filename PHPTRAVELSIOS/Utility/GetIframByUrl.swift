//
//  GetIframByUrl.swift
//  memuDemo
//
//  Created by Qasim Hussain on 11/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class GetIframByUrl: NSObject {
    
    
    override init() {
        
    }
    func getUrlByName(name : String,onCompletion:@escaping (String,String)->Void)
    {
        NetworkManager.sharedInstance.requestGETURL("\(Constant.domain)modulesinfo/\(name)?appKey=\(Constant.key)", success: { (json) in
            
            var myResponse = json["response"]
            
            let url = myResponse["url"].stringValue
            
            onCompletion(url,"")
            
        }) { (error) in
            
            onCompletion("",error.localizedDescription)
        }
    }
    func getHotelCombined(onCompletion:@escaping (String,String)->Void)
    {
        
        NetworkManager.sharedInstance.requestGETURL("\(Constant.domain)modulesinfo/hotelscombined?appKey=\(Constant.key)", success: { (json) in
            
            var myResponse = json["response"]
            
            let url = "http://brands.datahc.com/?a_aid=\(myResponse["aid"].stringValue)&brandid=\(myResponse["brandID"].stringValue)&languageCode=en"
            
            onCompletion(url,"")
            
        }) { (error) in
            
            onCompletion("",error.localizedDescription)
        }
    }
    func getCartrawler(onCompletion:@escaping (String,String)->Void)
    {
        
        NetworkManager.sharedInstance.requestGETURL("\(Constant.domain)modulesinfo/cartrawler?appKey=\(Constant.key)", success: { (json) in
            
            
            var myResponse = json["response"]
            
            let url = "https://book.cartrawler.com/?client=\(myResponse["cid"].stringValue)#/searchcars"
            
            onCompletion(url,"")
            
        }) { (error) in
            
            onCompletion("",error.localizedDescription)
        }
    }
    func getIvisa(from : String, to : String,onCompletion:@escaping (String,String)->Void)
    {
        print("\(Constant.domain)ivisa/frame?appKey=\(Constant.key)&nationality_country=\(from)&destination_country=\(to)")
        NetworkManager.sharedInstance.requestGETURL("\(Constant.domain)ivisa/frame?appKey=\(Constant.key)&nationality_country=\(from)&destination_country=\(to)", success: { (json) in
            
            
            
            if json["status"].stringValue == "fail"{
                
                onCompletion(json["error"]["next_url"].stringValue,"")
            }else if json["status"].stringValue == "error"{
                
                let error = json["error"]["message"].stringValue
                onCompletion("",error)
                
                
            }else{
                let url = json["data"]["frame_url"].stringValue
                onCompletion(url,"success")
            }
            
            
        }) { (error) in
            
            onCompletion("",error.localizedDescription)
        }
    }
}

