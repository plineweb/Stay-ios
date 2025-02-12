//
//  ManualFlightDetialsController.swift
//  PHPTRAVELSIOS
//
//  Created by Qasim Hussain on 6/23/18.
//  Copyright © 2018 Qasim Hussain. All rights reserved.
//

import UIKit
import Toaster

class ManualFlightDetialsController: UIViewController {

    @IBOutlet weak var table: ManualFlightDetialsTable!
    @IBOutlet weak var mainImage: UIImageView!
    var flight_info : HotelInfo? = nil
    var cabin_info : TourInfo? = nil
    var mainArray : [OneWayModel] = []
    var id : String = ""
    var url : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
       self.table.mainArray = mainArray
        let imgURL = URL(string:url)
        mainImage.sd_setShowActivityIndicatorView(true)
        mainImage.sd_setIndicatorStyle(.gray)
        mainImage.sd_setImage(with: imgURL)
        // Do any additional setup after loading the view.
        
        
        
    }

    @IBAction func Continue(_ sender: UIButton) {
        
        if CommonMethods.preferences.object(forKey: "login") == nil ||  CommonMethods.checkCoupon{
            
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "CarHotelTour", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "InvoiceController") as! InvoiceController
            newViewcontroller.checkType = "flights"
            newViewcontroller.id = id
            newViewcontroller.hotels_info = flight_info
            newViewcontroller.tour_info = cabin_info
            self.navigationController?.pushViewController(newViewcontroller, animated: true)
        
        }else{
         
            
            let user : [String] =  CommonMethods.preferences.array(forKey: "login") as! [String]
            
            var pro = HotelInfo(id : "",child : "",adult : "" ,checkin : "", checkout : "")
            
            
            FlightBooking().FlightBooking(guest: "", profile: pro,flight_info: self.flight_info!, coupon_id: CouponController.Coupon_id, id : user[2],cabin_class : self.cabin_info!,itemId : self.id) { (result,error) in
                
                if error != ""{
                    Toast.init(text : error).show()
                }else{
                    if result[0] == "yes"{
                        
                        Toast.init(text: result[1]).show()
                        
                    }else{
                        let mainstoryboard:UIStoryboard = UIStoryboard(name: "CarHotelTour", bundle: nil)
                        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "webview") as! WebViewHomeController
                        newViewcontroller.url = result[1]
                        self.navigationController?.pushViewController(newViewcontroller, animated: true)
                    }
                }
            }
            
            
            
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
