//
//  NetworkManager.swift
//  memuDemo
//
//  Created by Qasim Hussain on 22/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

class NetworkManager: NSObject {
    
    static let sharedInstance = NetworkManager()
    
    //TODO :-
    /* Handle Time out request alamofire */
    
    
    
    func requestGETURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void)
    {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 500
        
        
        
        manager.request("\(strURL)").validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let res = JSON(data)
                
                success(res)
                
                SVProgressHUD.dismiss()
                
            case .failure(let error):
                
                failure(error)
                
            }
        }
    }
    
    func requestPOSTURL(_ strURL : String, params : [String : Any]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 500
        
        manager.request(strURL, method: .post, parameters: params, headers:headers).responseJSON {(responseObject) -> Void in
            //print(responseObject)
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
}

