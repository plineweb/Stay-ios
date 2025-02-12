//
//  Login_Book.swift
//  memuDemo
//
//  Created by Qasim Hussain on 15/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster
import SVProgressHUD

class Login_Book: UIViewController {
    
    
    @IBOutlet weak var hide: UIView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    var model : String? = nil
    var tour_info : TourInfo? = nil
    var car_info : CarInfo? = nil
    var url : String = ""
    var outbound_rec : [TravelPortDetails] = []
    var inbound_rec : [TravelPortDetails] = []
    var hotels_info : HotelInfo? = nil
    var roomOb : Room_Model? = nil
    var tourInfo : TourInfo? = TourInfo(id : "",location: "", date: "",adults: "",type: "",child : "",infants : "")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        if self.model == "travelport"{
            hide.isHidden = false
        }
    }
    

    @IBAction func GuestBooking(_ sender: UIButton) {
        
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "TravelPort", bundle: nil)
        let searchController  = mainstoryboard.instantiateViewController(withIdentifier: "T_p_checkout") as! T_p_checkout
        searchController.outbound_rec = self.outbound_rec
        searchController.inbound_rec = self.inbound_rec
        searchController.tourInfo = self.tourInfo

        self.navigationController?.pushViewController(searchController, animated: true)
        
    }
    
    @IBAction func Login(_ sender: UIButton) {
        
        
        if (email.text?.isEmpty)! || (password.text?.isEmpty)! {
            
            let toast = Toast(text: "Please Fill The Above Requirments")
            toast.show()
            
            
        }else {
            
            let p : [String:String] = ["email":"\(email.text!)" ,"password":"\(password.text!)"]
            
            SVProgressHUD.setForegroundColor(.white)
            SVProgressHUD.show(withStatus: "Loading")
            SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
            NetworkManager.sharedInstance.requestPOSTURL("\(Constant.domain)login/check?appKey=\(Constant.key)", params: p, success: { (json) in
                
                var login_arr = [String]()
                
                
                if json["response"].bool! {
                    
                    let jsonObject = json["userInfo"]
                    
                    login_arr.append("true")
                    login_arr.append(jsonObject["email"].stringValue)
                    login_arr.append(jsonObject["id"].stringValue)
                    login_arr.append("\(jsonObject["firstName"].stringValue) \(jsonObject["lastName"].stringValue)")
                    
                    CommonMethods.preferences.set(login_arr, forKey: "login")
                    
                    CommonMethods.preferences.synchronize()
                    
                    
                    let pro = HotelInfo(id : "",child : "",adult : "" ,checkin : "", checkout : "")
                    
    
                    
                    if self.model == "tours"{
                        
                        
                        SVProgressHUD.setForegroundColor(.white)
                        SVProgressHUD.show(withStatus: "Loading")
                        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
                        TourBookingRequest().TourBookingLogin(guest: "", profile: pro, coupon_id: CouponController.Coupon_id, id : login_arr[2],tour_info : self.tour_info!) { (result,error) in
                            
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
                        
                        
                    }else if self.model == "hotels"{
                        
                        SVProgressHUD.setForegroundColor(.white)
                        SVProgressHUD.show(withStatus: "Loading")
                        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
                        HotelBookingRequest().HotelBooking(guest: "", profile: pro, coupon_id: CouponController.Coupon_id, id : login_arr[2],hotel_info : self.hotels_info!,roomOb : self.roomOb!) { (result,error) in
                            
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
                        
                        
                    }else if self.model == "cars"{
                        
                        SVProgressHUD.setForegroundColor(.white)
                        SVProgressHUD.show(withStatus: "Loading")
                        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
                        CarBookingRequest().CarBooking(guest: "", profile: pro, coupon_id: CouponController.Coupon_id, id : login_arr[2],car_info : self.car_info!) { (result,error) in
                            
                            if error != ""{
                                Toast.init(text : error).show()
                            }else{
                                if result[0] == "yes"{
                                    
                                    Toast.init(text: result[1]).show()
                                    
                                }else{
                                    
                                    self.url = result[1]
                                    self.performSegue(withIdentifier: "show_webview", sender: self)
                                }
                            }
                        }
                    }else if self.model == "travelport"{
                        
                        let mainstoryboard:UIStoryboard = UIStoryboard(name: "TravelPort", bundle: nil)
                        let searchController  = mainstoryboard.instantiateViewController(withIdentifier: "T_p_checkout") as! T_p_checkout
                        searchController.outbound_rec = self.outbound_rec
                        searchController.inbound_rec = self.inbound_rec
                        searchController.tourInfo = self.tourInfo
                        self.navigationController?.pushViewController(searchController, animated: true)
                    }
                }else{
                    
                    let error_object = json["error"]
                    
                    login_arr.append("false")
                    login_arr.append("")
                    login_arr.append(error_object["msg"].stringValue)
                    login_arr.append("")
                    
                    Toast(text: login_arr[2]).show()
                    
                    SVProgressHUD.dismiss()

                }
                
                
                
            }) { (error) in
                
                SVProgressHUD.dismiss()
                Toast.init(text : error.localizedDescription).show()
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
    }
    
}
