//
//  InvoiceController.swift
//  memuDemo
//
//  Created by Qasim Hussain on 14/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class InvoiceController: UIViewController {

    var roomObject : Room_Model? = nil
    let uiView : UIView = UIView()
    var customSC : UISegmentedControl? = nil
    var items : [String] = []
    var login_view : Login_Book? = nil
    var guest_view : GuestController? = nil
    var coupon_view : CouponController? = nil
    var checkType : String? = nil
    var user_id : String? = nil
    var tour_info : TourInfo? = nil
    var hotels_info : HotelInfo? = nil
    var cars_info : CarInfo? = nil
    var id : String = ""


    var roomOb : Room_Model? = nil


    
    
    override func loadView() {
        super.loadView()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        CouponController.Coupon_id = "0"
        
        self.view.backgroundColor = CommonMethods.hexStringToUIColor(hex: "#EEEEEE")
        
        initMenu()

        
        if checkType == "tours"{
        
            coupon_view?.model = "tours"
            coupon_view?.tour_info = tour_info
         
            login_view?.model = "tours"
            login_view?.tour_info = tour_info
        
            guest_view?.model = "tours"
            guest_view?.tour_info = tour_info
        }else if checkType == "hotels"{
        
            coupon_view?.model = "hotels"
            coupon_view?.hotels_info = self.hotels_info
            coupon_view?.roomOb = self.roomOb

            
            login_view?.model = "hotels"
            login_view?.hotels_info = self.hotels_info
            login_view?.roomOb = self.roomOb
         
            guest_view?.model = "hotels"
            guest_view?.hotels_info = self.hotels_info
            guest_view?.roomOb = self.roomOb
        
        }else if checkType == "cars"{
            
            coupon_view?.model = "cars"
            coupon_view?.car_info = self.cars_info
            
            
            login_view?.model = "cars"
            login_view?.car_info = self.cars_info
            
            guest_view?.model = "cars"
            guest_view?.car_info = self.cars_info
            
        }else if checkType == "flights"{
            
            coupon_view?.model = "flights"
            coupon_view?.hotels_info = self.hotels_info
            coupon_view?.tour_info = self.tour_info
            coupon_view?.itemId = self.id
            
            
            login_view?.model = "flights"
            login_view?.hotels_info = self.hotels_info
            login_view?.tour_info = self.tour_info
            login_view?.item = self.id
            
            
            guest_view?.model = "flights"
            guest_view?.hotels_info = self.hotels_info
            guest_view?.tour_info = self.tour_info
            guest_view?.itemID = self.id

            
            
        }
        
    }
    
    
    @objc func changeColor(sender: UISegmentedControl) {
        
        if sender.titleForSegment(at: sender.selectedSegmentIndex) == "LOGIN"{
            login_view?.view.frame = uiView.bounds
            uiView.addSubview((login_view?.view)!)
            addChildViewController(login_view!)
            login_view?.didMove(toParentViewController: self)
        }
        else if sender.titleForSegment(at: sender.selectedSegmentIndex) == "GUEST" {
            guest_view?.view.frame = uiView.bounds
            uiView.addSubview((guest_view?.view)!)
            addChildViewController(guest_view!)
            guest_view?.didMove(toParentViewController: self)
        
        }else if sender.titleForSegment(at: sender.selectedSegmentIndex) == "COUPON" {
            coupon_view?.view.frame = uiView.bounds
            uiView.addSubview((coupon_view?.view)!)
            addChildViewController(coupon_view!)
            coupon_view?.didMove(toParentViewController: self)
            
        }
    }
    
    func initMenu(){
    
        login_view = self.storyboard?.instantiateViewController(withIdentifier: "Login_Book") as? Login_Book
        guest_view = self.storyboard?.instantiateViewController(withIdentifier: "GuestController") as? GuestController
        coupon_view = self.storyboard?.instantiateViewController(withIdentifier: "CouponController") as?CouponController
        
        if CommonMethods.preferences.object(forKey: "login") == nil {
            
            items = ["LOGIN", "GUEST"]
            
        } else {
            
            let user : [String] =  CommonMethods.preferences.array(forKey: "login") as! [String]
            user_id = user[2]
            
        }
        

            if CommonMethods.checkCoupon
            {
                items.append("COUPON")
                
            }

        self.customSC = UISegmentedControl(items: items)
        self.customSC?.selectedSegmentIndex = 0
        
        let frame = UIScreen.main.bounds
        customSC?.frame = CGRect(x: frame.minX + 10, y: frame.minY + 70, width: frame.width - 20, height: 50)
        
        uiView.frame = CGRect(x: frame.minX + 10, y:  frame.minY + (customSC?.frame.height)!+80, width: frame.width - 20, height: frame.height-(customSC?.frame.height)!-140)
        
        
        
        
        
        // Style the Segmented Control
        self.customSC?.layer.cornerRadius = 5.0  // Don't let background bleed
        self.customSC?.backgroundColor = CommonMethods.hexStringToUIColor(hex: "#283349")
        self.customSC?.tintColor = UIColor.white
        
        // Add target action method
        self.customSC?.addTarget(self, action:#selector(changeColor), for: .valueChanged)
        
        // Add this custom Segmented Control to our view
        self.view.addSubview(customSC!)
        
        self.view.addSubview(uiView)
        
        
        if self.customSC?.titleForSegment(at: 0) == "LOGIN"{
            login_view?.view.frame = uiView.bounds
            uiView.addSubview((login_view?.view)!)
            addChildViewController(login_view!)
            login_view?.didMove(toParentViewController: self)
        }
        else if self.customSC?.titleForSegment(at: 0) == "GUEST" {
            guest_view?.view.frame = uiView.bounds
            uiView.addSubview((guest_view?.view)!)
            addChildViewController(guest_view!)
            guest_view?.didMove(toParentViewController: self)
            
        }else if self.customSC?.titleForSegment(at: 0) == "COUPON" {
            coupon_view?.view.frame = uiView.bounds
            uiView.addSubview((coupon_view?.view)!)
            addChildViewController(coupon_view!)
            coupon_view?.didMove(toParentViewController: self)
            
        }
    }

}
