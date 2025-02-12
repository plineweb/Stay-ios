//
//  MyBookingController.swift
//  memuDemo
//
//  Created by Qasim Hussain on 12/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster
import SVProgressHUD

class MyBookingController: UIViewController {


    @IBOutlet weak var booking_table: MyBookingTable!
    var url : String = ""
    @IBOutlet weak var menu: UIBarButtonItem!
    var id : String = ""
    let mainstoryboard:UIStoryboard = UIStoryboard(name: "CarHotelTour", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationController?.navigationBar.barTintColor =  CommonMethods.hexStringToUIColor(hex: "#2E3192")
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        if CommonMethods.preferences.object(forKey: "login") == nil {
            //  Doesn't exist
        } else {
            
            let decoded : Array  = CommonMethods.preferences.array(forKey: "login")!
            self.id = decoded[2] as! String
            
        }
        
        self.booking_table.controler = self
        
        
        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Loading")
        NetworkManager.sharedInstance.requestGETURL("\(Constant.domain)invoice/list?appKey=\(Constant.key)&userid=\(id)", success: { (json) in
            
            var hotelArray = [HotelListing]()
            var result : HotelListing = HotelListing(h_name: "", h_location: "", h_ration: "", h_star: "", h_price: "", h_image: "", id: "")

            var myResponse = json["response"]
            
            for i in (0..<myResponse.count).reversed(){
                var checkin = ""
                var checkout = ""
                let name =  myResponse[i]["title"].stringValue
                let location = myResponse[i]["thumbnail"].stringValue
                
                if myResponse[i]["checkout"].stringValue == ""{
                    
                     checkin = "Date : \(myResponse[i]["checkin"].stringValue)"
                    checkout = ""

                }else{
                    checkin = "check In : \(myResponse[i]["checkin"].stringValue)"
                    checkout = "check out : \(myResponse[i]["checkout"].stringValue)"

                }
                let price = "\(myResponse[i]["checkoutTotal"].stringValue)\(myResponse[i]["currCode"].stringValue)"
                let code = myResponse[i]["code"].stringValue
                let id = myResponse[i]["id"].stringValue
                
                
                result = HotelListing(h_name:name, h_location: location, h_ration: checkin , h_star: checkout,
                    h_price: price, h_image: code, id: id)
                
                hotelArray.append(result)
            
            }
            self.booking_table.mainArray = hotelArray
            SVProgressHUD.dismiss()

            
        }) { (error) in
            
            Toast.init(text: error.localizedDescription).show()
            SVProgressHUD.dismiss()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
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
