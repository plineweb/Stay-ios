//
//  OffersList.swift
//  memuDemo
//
//  Created by Qasim Hussain on 10/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import SVProgressHUD
import Toaster

class OffersList: UIViewController {

    @IBOutlet weak var offer_table: OffersTable!
    
    @IBOutlet weak var menu: UIBarButtonItem!
    var controller : OffersList? = nil
    var offerObject : HotelListing? = nil

    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationController?.navigationBar.barTintColor =  CommonMethods.hexStringToUIColor(hex: "#2E3192")
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        var Result_Array:[HotelListing] = []

        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Loading")
        NetworkManager.sharedInstance.requestGETURL("\(Constant.domain)offers/list?appKey=\(Constant.key)", success: { (json) in
            
            var mainArray = json["response"]
            
            for index in 0..<mainArray.count{
                
                var indexObject = mainArray[index]
                let h_name = indexObject["title"].stringValue
                let h_id = indexObject["id"].stringValue
                
                let h_location = indexObject["location"].stringValue
                let h_ration =  indexObject["desc"].stringValue
                let h_price = "\(indexObject["price"].stringValue) \(indexObject["currCode"])"
                let h_image = indexObject["thumbnail"].stringValue
                
                let a = HotelListing(h_name: h_name, h_location: h_location, h_ration: h_ration, h_star: "", h_price: h_price, h_image: h_image, id: h_id)
                
                    Result_Array.append(a)
                 }
            SVProgressHUD.dismiss()

            self.offer_table.HotelsObject = Result_Array
            self.offer_table.controller = self


            
        }) { (error) in
            SVProgressHUD.dismiss()
            
            Toast.init(text: error.localizedDescription).show()
        }
      
    }
    override func viewDidAppear(_ animated: Bool) {
        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
            let searching = segue.destination as! OffersDetails
            searching.overview = offerObject
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
