//
//  CouponController.swift
//  memuDemo
//
//  Created by Qasim Hussain on 16/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster
import SVProgressHUD

class CouponController: UIViewController {

    @IBOutlet weak var hide_view: UIView!
    @IBOutlet weak var coupon_code: UITextField!
    
    static var  Coupon_id = "0"
    var url : String = ""

    var model : String? = nil
    var user_id  = ""
    
    var tour_info : TourInfo? = nil
    var hotels_info : HotelInfo? = nil
    var car_info : CarInfo? = nil

    var roomOb : Room_Model? = nil
    


    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.white

        if CommonMethods.preferences.object(forKey: "login") == nil {
            
           hide_view.isHidden = true
            
        } else {
            let user : [String] =  CommonMethods.preferences.array(forKey: "login") as! [String]
            hide_view.isHidden = false
            self.user_id = user[2]
        }
        
        
    }


    @IBAction func check_coupon(_ sender: UIButton) {
        
        if coupon_code.text != ""{
        
            var p : [String:String] = [:]
            if self.model == "tours"{
            
                 p  =
                    ["code":"\(self.coupon_code.text!)" ,
                        "itemId":"\((tour_info?.id)!)",
                        "module":"\(self.model!)"
                ]
                
            }else if self.model == "hotels"{
            
                 p  = ["code":"\(self.coupon_code.text!)" ,
                        "itemId":"\((hotels_info?.id)!)",
                        "module":"\(self.model!)"
                ]
            
            }else if self.model == "cars"{
                
                p  = ["code":"\(self.coupon_code.text!)" ,
                    "itemId":"\((car_info?.id)!)",
                    "module":"\(self.model!)"
                ]
                
            }
            SVProgressHUD.setForegroundColor(.white)
            SVProgressHUD.show(withStatus: "Loading")
            SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
            
            NetworkManager.sharedInstance.requestPOSTURL("\(Constant.domain)invoice/verifyCoupon?appKey=\(Constant.key)", params: p, success: { (json) in
                
                
                var myResponse = json["response"]
                
                if myResponse["status"].stringValue == "success"{
                    
                
                    CouponController.Coupon_id = myResponse["couponid"].stringValue
                    Toast(text: "Coupon Applied Successfully").show()
                    self.view.endEditing(true)
                    
                }else{
                    
                    self.view.endEditing(true)
                    Toast(text: (myResponse["msg"].stringValue)).show()
                 }
                SVProgressHUD.dismiss()

                
            }) { (error) in
                
                SVProgressHUD.dismiss()
                Toast.init(text : error.localizedDescription).show()
            }
        
    }
    }
    @IBAction func continue_booking(_ sender: UIButton) {
        
        
        let pro = HotelInfo(id : "",child : "",adult : "" ,checkin : "", checkout : "")
        
        if self.model == "tours"
        {
            TourBookingRequest().TourBookingLogin(guest: "", profile: pro, coupon_id: CouponController.Coupon_id, id : self.user_id,tour_info : self.tour_info!) { (result,error) in
                
                if error != ""{
                    
                    Toast.init(text: error).show()
                    SVProgressHUD.dismiss()
                    
                }else{
                    if result[0] == "yes"{
                        
                        Toast.init(text: result[1]).show()
                        
                    }else{
                        
                        self.url = result[1]
                        self.performSegue(withIdentifier: "show_webview", sender: self)
                    }
                    
                }
            }
        } else if self.model == "hotels"{
            
            
            HotelBookingRequest().HotelBooking(guest: "", profile: pro, coupon_id: CouponController.Coupon_id, id : user_id,hotel_info : self.hotels_info!,roomOb : roomOb!) { (result,error) in
                
                if error != ""{
                    
                    Toast.init(text: error).show()
                    SVProgressHUD.dismiss()

                }else{
                    if result[0] == "yes"{
                        
                        Toast.init(text: result[1]).show()
                        
                    }else{
                        
                        self.url = result[1]
                        self.performSegue(withIdentifier: "show_webview", sender: self)
                    }
                    
                }
                
                
            }
            
        }else if self.model == "cars"{
            
            
            CarBookingRequest().CarBooking(guest: "", profile: pro, coupon_id: CouponController.Coupon_id, id : user_id,car_info : self.car_info!) { (result,error) in
                
                if error != ""{
                    Toast.init(text: error).show()

                }else{
                if result[0] == "yes"{
                    
                    Toast.init(text: result[1]).show()
                    
                }else{
                    
                    self.url = result[1]
                    self.performSegue(withIdentifier: "show_webview", sender: self)
                }
                }
                
                
            }
            
        }
        
    

        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_webview"{
            
            let searching = segue.destination as! WebViewHomeController
            searching.url = self.url
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
