//
//  SplashScreen.swift
//  memuDemo
//
//  Created by APPLE on 01/06/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster

class SplashScreen: UIViewController {
    
    
    @IBOutlet weak var indicatior: UIActivityIndicatorView!
    
    @IBOutlet weak var hide_view: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //self.hide_view.isHidden = true
        
        sendData()
        
    }
    
    func sendData(){
        
        
        NetworkManager.sharedInstance.requestGETURL("\(Constant.domain)modulesinfo/list?appKey=\(Constant.key)", success: { (json) in
            
            var error = json["error"]
            
            if error["status"].boolValue {
                
                Toast.init(text: error["msg"].stringValue).show()
                
                
            }else{
                var mainObject = json["response"]
                var md : Module? = nil
                
                for i in 0..<mainObject.count {
                    
                    var model_object = mainObject[i]
                    
                    if model_object["status"].boolValue {
                        
                        if model_object["title"].stringValue.lowercased() == "travelport_flight"{
                            
                            md = Module(title: "FLIGHTS", type: "0")
                            
                            CommonMethods.ModeluArray.append(md!)
                        }
                        else if model_object["title"].stringValue.lowercased() == "hotels"{
                            
                            md = Module(title: "HOTELS", type: "1")
                            
                            CommonMethods.ModeluArray.append(md!)
                        }else if model_object["title"].stringValue.lowercased() == "ean"{
                            
                            md = Module(title: "HOTELS", type: "2")
                            
                            CommonMethods.ModeluArray.append(md!)
                        }else if model_object["title"].stringValue.lowercased() == "tours"{
                            
                            md = Module(title: "TOURS", type: "3")
                            
                            CommonMethods.ModeluArray.append(md!)
                        }else if model_object["title"].stringValue.lowercased() == "cars"{
                            
                            md = Module(title: "CARS", type: "4")
                            
                            CommonMethods.ModeluArray.append(md!)
                        }else if model_object["title"].stringValue.lowercased() == "travelpayouts"{
                            
                            md = Module(title: "FLIGHTS", type: "5")
                            print("Cartraller Called")
                            CommonMethods.ModeluArray.append(md!)
                        }else if model_object["title"].stringValue.lowercased() == "travelstart"{
                            
                            md = Module(title: "FLIGHTS", type: "6")
                            CommonMethods.ModeluArray.append(md!)
                        }else if model_object["title"].stringValue.lowercased() == "cartrawler"{
                            
                            md = Module(title: "CARS", type: "7")
                            CommonMethods.ModeluArray.append(md!)
                        }else if model_object["title"].stringValue.lowercased() == "hotelscombined"{
                            
                            md = Module(title: "CARS", type: "8")
                            CommonMethods.ModeluArray.append(md!)
                        }else if model_object["title"].stringValue.lowercased() == "wegoflights"{
                            
                            md = Module(title: "FLIGHTS", type: "9a")
                            CommonMethods.ModeluArray.append(md!)
                        }else if model_object["title"].stringValue.lowercased() == "ivisa"{
                            
                            md = Module(title: "IVISA", type: "9b")
                            CommonMethods.ModeluArray.append(md!)
                        }else if model_object["title"].stringValue.lowercased() == "blog"{
                            
                            md = Module(title: "blog", type: "-1")
                            CommonMethods.ModeluArray.append(md!)
                        }else if model_object["title"].stringValue.lowercased() == "offers"{
                            
                            md = Module(title: "offers", type: "-1")
                            CommonMethods.ModeluArray.append(md!)
                        }else if model_object["title"].stringValue.lowercased() == "coupons"{
                            
                            CommonMethods.checkCoupon = true
                        }
                        
                    }
                    
                }
                self.performSegue(withIdentifier: "show_main", sender: self)
                
            }
        }) { (error) in
            
            Toast.init(text: error.localizedDescription).show()
            self.hide_view.isHidden = false
            self.indicatior.stopAnimating()
        }
        
    }
    
    @IBAction func try_agian(_ sender: UIButton) {
        
        self.hide_view.isHidden = true
        self.indicatior.startAnimating()
        sendData()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

