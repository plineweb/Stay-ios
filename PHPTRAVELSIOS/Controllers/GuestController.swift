//
//  GuestController.swift
//  memuDemo
//
//  Created by Qasim Hussain on 15/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster

class GuestController: UIViewController {

    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone_number: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var last_name: UITextField!
    @IBOutlet weak var first_name: UITextField!
    var url : String = ""

    var model : String? = nil
    
    var hotels_info : HotelInfo? = nil
    var car_info : CarInfo? = nil

    var roomOb : Room_Model? = nil
    
    var tour_info : TourInfo? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        // Do any additional setup after loading the view.
    }

    @IBAction func Bookit(_ sender: UIButton) {
        
        if first_name.text == "" || last_name.text == "" || email.text == "" || phone_number.text == "" || address.text == ""{
        
        }else{
        
            let profile : HotelInfo = HotelInfo(id : first_name.text!,child : last_name.text!,adult : email.text! ,checkin : phone_number.text!, checkout : address.text!)
            
            if self.model == "tours"{
            
                TourBookingRequest().TourBookingLogin(guest: "guest", profile: profile, coupon_id: CouponController.Coupon_id , id : "0",tour_info : self.tour_info!) { (result,error) in
                    
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
            
                HotelBookingRequest().HotelBooking(guest: "guest", profile: profile, coupon_id: CouponController.Coupon_id, id : "0",hotel_info : self.hotels_info!,roomOb : self.roomOb!) { (result,error) in
                    
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
                
                
                CarBookingRequest().CarBooking(guest: "guest", profile: profile, coupon_id: CouponController.Coupon_id, id : "0",car_info : self.car_info!) { (result,error) in
                    
              
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
