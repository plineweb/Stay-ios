//
//  MainTabBar.swift
//  tabed
//
//  Created by APPLE on 29/05/2017.
//  Copyright © 2017 PHPTRAVELS. All rights reserved.
//

import UIKit


class MainTabBar: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let car_hotel_tour:UIStoryboard = UIStoryboard(name: "CarHotelTour", bundle: nil)
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        var mainArray : [UIViewController] = []
        
        let m_arr = CommonMethods.ModeluArray.sorted(by: { $0.type < $1.type })
        
        for i in 0..<m_arr.count {
            
            let m = m_arr[i]
            
            if m.type == "1"
            {
                let pt_hotel_tabs = car_hotel_tour.instantiateViewController(withIdentifier: "HotelHomeController") as! HotelHomeController
                let HotelController = UINavigationController.init(rootViewController: pt_hotel_tabs)
                HotelController.tabBarItem=UITabBarItem.init(title: "HOTELS", image: #imageLiteral(resourceName: "hotels"), tag: 0)
                mainArray.append(HotelController)

            }else  if m.type == "0"
            {
                let travelstoryboard:UIStoryboard = UIStoryboard(name: "TravelPort", bundle: nil)
                let pt_hotel_tabs = travelstoryboard.instantiateViewController(withIdentifier: "TravelPortController") as! TravelPortController
                let HotelController = UINavigationController.init(rootViewController: pt_hotel_tabs)
                HotelController.tabBarItem=UITabBarItem.init(title: "FLIGHTS", image: #imageLiteral(resourceName: "ic_flight"), tag: 0)
                mainArray.append(HotelController)

            }else  if m.type == "2"
            {
                let travelstoryboard:UIStoryboard = UIStoryboard(name: "TravelPort", bundle: nil)
                let pt_hotel_tabs = travelstoryboard.instantiateViewController(withIdentifier: "TravelPortController") as! TravelPortController
                pt_hotel_tabs.checkManual = "manual"

                let HotelController = UINavigationController.init(rootViewController: pt_hotel_tabs)
                HotelController.tabBarItem=UITabBarItem.init(title: "FLIGHTS", image: #imageLiteral(resourceName: "ic_flight"), tag: 0)
                mainArray.append(HotelController)

            }else if m.type == "3"{
                
                let pt_tour_tabs = car_hotel_tour.instantiateViewController(withIdentifier: "TourHomeController") as! TourHomeController
                let TourController = UINavigationController.init(rootViewController: pt_tour_tabs)
                TourController.tabBarItem=UITabBarItem.init(title: "TOUR", image: #imageLiteral(resourceName: "tours"), tag: 0)
                mainArray.append(TourController)

                
            }else if m.type == "4"{
                let pt_car_tabs = car_hotel_tour.instantiateViewController(withIdentifier: "CarHomeController") as! CarHomeController
                let CarController = UINavigationController.init(rootViewController: pt_car_tabs)
                CarController.tabBarItem=UITabBarItem.init(title: "CARS", image: #imageLiteral(resourceName: "cars"), tag: 0)
                mainArray.append(CarController)
            }else if m.type == "5"{
                let pt_car_tabs = mainstoryboard.instantiateViewController(withIdentifier: "WebViewModelController") as! WebViewModelController
                pt_car_tabs.type = "travelpayouts"
                let CarController = UINavigationController.init(rootViewController: pt_car_tabs)
                CarController.tabBarItem=UITabBarItem.init(title: "FLIGHTS", image: #imageLiteral(resourceName: "ic_flight"), tag: 0)
                mainArray.append(CarController)

            }
            else if m.type == "6"{
                let pt_car_tabs = mainstoryboard.instantiateViewController(withIdentifier: "WebViewModelController") as! WebViewModelController
                pt_car_tabs.type = "travelstart"
                let CarController = UINavigationController.init(rootViewController: pt_car_tabs)
                CarController.tabBarItem=UITabBarItem.init(title: "FLIGHTS", image: #imageLiteral(resourceName: "ic_flight"), tag: 0)
                mainArray.append(CarController)

            }
            else if m.type == "7"{
                let pt_car_tabs = mainstoryboard.instantiateViewController(withIdentifier: "WebViewModelController") as! WebViewModelController
                pt_car_tabs.type = "cartrawler"
                
                let CarController = UINavigationController.init(rootViewController: pt_car_tabs)
                CarController.tabBarItem=UITabBarItem.init(title: "CARS", image: #imageLiteral(resourceName: "ic_flight"), tag: 0)
                mainArray.append(CarController)

            }  else if m.type == "8"{
                let pt_car_tabs = mainstoryboard.instantiateViewController(withIdentifier: "WebViewModelController") as! WebViewModelController
                pt_car_tabs.type = "hotelscombined"
                let CarController = UINavigationController.init(rootViewController: pt_car_tabs)
                CarController.tabBarItem=UITabBarItem.init(title: "HOTELS", image: #imageLiteral(resourceName: "hotels"), tag: 0)
                mainArray.append(CarController)

            } else if m.type == "9a"{
                let pt_car_tabs = mainstoryboard.instantiateViewController(withIdentifier: "WebViewModelController") as! WebViewModelController
                pt_car_tabs.type = "wego"
                let CarController = UINavigationController.init(rootViewController: pt_car_tabs)
                CarController.tabBarItem=UITabBarItem.init(title: "FLIGHTS", image: #imageLiteral(resourceName: "ic_flight"), tag: 0)
                mainArray.append(CarController)

            }else if m.type == "9b"{
                let pt_car_tabs = mainstoryboard.instantiateViewController(withIdentifier: "IVISAHOME") as! IVISAHOME
                let CarController = UINavigationController.init(rootViewController: pt_car_tabs)
                CarController.tabBarItem=UITabBarItem.init(title: "VISA", image: #imageLiteral(resourceName: "passport"), tag: 0)
                mainArray.append(CarController)
            }
            self.viewControllers = mainArray
        }
        
        let appearance = UITabBarItem.appearance()
        appearance.titlePositionAdjustment = UIOffsetMake(0, 0);
        
        let colorNormal : UIColor = UIColor.white
        let titleFontAll : UIFont = UIFont(name: "Open Sans", size: 14.0)!
        
        let attributesNormal = [
            NSAttributedStringKey.foregroundColor : colorNormal,
            NSAttributedStringKey.font : titleFontAll
        ]
        
        UITabBarItem.appearance().setTitleTextAttributes(attributesNormal, for: .normal)
        
//        let attributes: [String: AnyObject] = [NSFontAttributeName.rawValue:UIFont(name: "Open Sans", size: 14)!, NSForegroundColorAttributeName: UIColor.white]
//        appearance.setTitleTextAttributes(attributes, for: .normal)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}

