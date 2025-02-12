//
//  TravelPortController.swift
//  memuDemo
//
//  Created by Qasim Hussain on 22/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster
import SVProgressHUD

class TravelPortController: UIViewController,UINavigationBarDelegate,UINavigationControllerDelegate ,EPCalendarPickerDelegate,cabinDataTransfer{
    
    @IBOutlet weak var return_text: UILabel!
    @IBOutlet weak var cabinData: UIButton!
    @IBOutlet weak var cancel_round: UIButton!
    
    @IBOutlet weak var location_from: UIButton!
    
    @IBOutlet weak var location_to: UIButton!
    @IBOutlet weak var topScreen: NSLayoutConstraint!
    
    @IBOutlet weak var container_view: UIView!
    var checkManual = "travelport"
    
    
    
    @IBOutlet weak var bt_date_from: UIButton!
    @IBOutlet weak var bt_date_to: UIButton!
    

    
    
    var check_data_type : String = ""
    
    var date_from_api : String?
    var date_to_api : String?
    var id_from : String = "0"
    var id_to : String = "0"
    
    var tourInfo : TourInfo? = TourInfo(id: "", location: "", date: "Economy", adults: "1", type: "", child: "0", infants: "0")
    
    var hotelInfo : HotelInfo = HotelInfo(id: "", child: "", adult: "", checkin: "", checkout: "")
    
    var decoded : Array<String> = []
    
    let preferences = UserDefaults.standard
    let searchkeyFlightsFrom = "search_travelport_from"
    let searchkeyFlightTo = "search_travelport_to"
    let searchkeyFlightsManualFrom = "search_from_manual"
    let searchkeyFlightsManualTo = "search_to_manual"
    let mainstoryboard:UIStoryboard = UIStoryboard(name: "CarHotelTour", bundle: nil)

    
    @IBOutlet weak var menu: UIBarButtonItem!
    
    var date_from : Date?
    
    var date_to : Date?
    var car_info : CarInfo? = nil
    let dateFormatter = DateFormatter()
    var checkReturn = ""
    
    
    var check_date : String?
    
    
    @IBOutlet weak var dateStack: UIStackView!
    
    
    
    @IBOutlet weak var rootStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        let c_view : UIViewController = (self.mainstoryboard.instantiateViewController(withIdentifier: "main_container_view"))

        
        c_view.view.frame = container_view.bounds
        container_view.addSubview((c_view.view)!)
        addChildViewController(c_view)
        c_view.didMove(toParentViewController: self)
        
        
        date_to = Date()
        
        date_from = Date()
        
        dateFormatter.dateFormat = "dd/MM/yyy"
        date_to = date_to?.dateByAddingDays(1)
        
        
        bt_date_from.setTitle(dateFormatter.string(from: date_from!), for: .normal)
        bt_date_to.setTitle("Add Return",for: .normal)
        checkReturn = "oneway"
        cancel_round.isHidden = true
        
        self.return_text.text = ""

        
        dateFormatter.dateFormat = "yyy-MM-dd"
        
        date_from_api = dateFormatter.string(from: date_from!)
        
        date_to_api = dateFormatter.string(from: (date_to)!)
        

        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        navigationController?.navigationBar.barTintColor =  hexStringToUIColor(hex: "#2E3192")
        
        pinBackground(backgroundView, to: rootStackView)
        
        
        
        
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        if screenHeight<500
        {
            topScreen.constant=100
            
        }else if screenHeight < 600
        {
            topScreen.constant=130
            
        }else if screenHeight > 600
        {
            topScreen.constant=150
            
        }
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        SVProgressHUD.dismiss()

        if checkManual != "manual"{
                if preferences.object(forKey: searchkeyFlightsFrom) == nil {
                    
                    
                }else {
                    
                    decoded  = preferences.array(forKey: searchkeyFlightsFrom)! as! Array<String>
                    location_from.setTitle(decoded[0], for: .normal)
                    self.id_from = decoded[2]
                }
            
                if preferences.object(forKey: searchkeyFlightTo) == nil {
                    
                } else {
                    
                    decoded  = preferences.array(forKey: searchkeyFlightTo)! as! Array<String>
                    location_to.setTitle(decoded[0], for: .normal)
                    self.id_to = decoded[2]
                }
        }else{
            if preferences.object(forKey: searchkeyFlightsManualFrom) == nil {
                
                
            }else {
                
                decoded  = preferences.array(forKey: searchkeyFlightsManualFrom)! as! Array<String>
                location_from.setTitle(decoded[0], for: .normal)
                self.id_from = decoded[2]
            }
            if preferences.object(forKey: searchkeyFlightsManualTo) == nil {
                
            } else {
                
                decoded  = preferences.array(forKey: searchkeyFlightsManualTo)! as! Array<String>
                location_to.setTitle(decoded[0], for: .normal)
                self.id_to = decoded[2]
            }
            
        }
        
    }
    
    
    @IBAction func oneWay(_ sender: UIButton) {
        
        cancel_round.isHidden = true
        bt_date_to.setTitle("Add Return",for : .normal)
        checkReturn = "oneway"
        self.return_text.text = ""
        
    }
    
    @IBAction func hotel_search(_ sender: Any) {
        
        if checkManual != "manual"{
            if location_from.title(for : .normal) == "ORIGAN" || location_to.title(for : .normal) == "DESTINATION"{
                
                hotelInfo = HotelInfo(id: checkReturn, child: "0", adult: "0", checkin: date_from_api!, checkout: date_to_api!)
                
                self.performSegue(withIdentifier: "show_travel_port", sender: self)
                
            }else{
                
                hotelInfo = HotelInfo(id: checkReturn, child: self.id_from, adult: self.id_to, checkin: date_from_api!, checkout: date_to_api!)
                
                self.performSegue(withIdentifier: "show_travel_port", sender: self)
                
            }
        }else{
            if location_from.title(for : .normal) == "ORIGAN" || location_to.title(for : .normal) == "DESTINATION"{
                
                Toast.init(text:"Please Specify Origin or Destination").show()
                
            }else{
                
                hotelInfo = HotelInfo(id: checkReturn, child: self.id_from, adult: self.id_to, checkin: date_from_api!, checkout: date_to_api!)
                let mainstoryboard:UIStoryboard = UIStoryboard(name: "TravelPort", bundle: nil)
                let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ManualFlights") as! ManualFlights
                newViewcontroller.flight_info = hotelInfo
                newViewcontroller.cabin_info = self.tourInfo
                self.navigationController?.pushViewController(newViewcontroller, animated: true)
                
            }
        }
        
        
        
        
    }
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 0.3)
        return view
    }()
    
    
    private func pinBackground(_ view: UIView, to stackView: UIStackView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(view, at: 0)
        view.pin(to: stackView)
    }
    
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func date_select(_ sender: UIButton) {
        
        if sender.tag == 0{
            
            
            check_date = "in"
            showDate(type: "",startDate: Date())
            
        }
        else if sender.tag == 1 {
            
            if checkReturn == "oneway"{
            
                dateFormatter.dateFormat = "dd/MM/yyy"
                bt_date_to.setTitle(dateFormatter.string(from: self.date_to!), for: .normal)
                dateFormatter.dateFormat = "yyy-MM-dd"
                date_to_api = dateFormatter.string(from: self.date_to!)
                checkReturn = "round"
                cancel_round.isHidden = false
                check_date = "out"
                self.return_text.text = "Return"

                
            }else{
                check_date = "out"
                showDate(type: "",startDate: date_to!)
                
            }
            
      
            
            
        }
        
    }
    
    
    
    func  showDate(type : String , startDate : Date) -> Void {
        
        
        let calendarPicker = EPCalendarPicker(startYear: Date().year(), endYear: Date().year()+1, multiSelection: false, selectedDates: [])
        calendarPicker.calendarDelegate = self
        calendarPicker.startDate = startDate
        calendarPicker.hightlightsToday = false
        calendarPicker.hideDaysFromOtherMonth = true
        //        calendarPicker.barTintColor = UIColor.greenColor()
        calendarPicker.dayDisabledTintColor = UIColor.gray
        calendarPicker.title = "CHECK IN"
        
        
        //        calendarPicker.backgroundImage = UIImage(named: "background_image")
        //        calendarPicker.backgroundColor = UIColor.blueColor()
        
        let navigationController = UINavigationController(rootViewController: calendarPicker)
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
    
    
    
    func epCalendarPicker(_: EPCalendarPicker, didCancel error : NSError) {
        
    }
    func epCalendarPicker(_: EPCalendarPicker, didSelectDate date : Date) {
        
        if check_date == "in"{
            
            dateFormatter.dateFormat = "dd/MM/yyy"
            bt_date_from.setTitle(dateFormatter.string(from: date), for: .normal)
            dateFormatter.dateFormat = "yyy-MM-dd"
            date_from_api = dateFormatter.string(from: date)
            self.date_to = date.dateByAddingDays(1)
            
            if checkReturn == "round"{
            
                dateFormatter.dateFormat = "dd/MM/yyy"
                bt_date_to.setTitle(dateFormatter.string(from: date.dateByAddingDays(1)), for: .normal)
                dateFormatter.dateFormat = "yyy-MM-dd"
                date_to_api = dateFormatter.string(from: date.dateByAddingDays(1))
                
            }

            
        } else {
            
            dateFormatter.dateFormat = "yyy-MM-dd"
            date_to_api = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "dd/MM/yyy"
            bt_date_to.setTitle(dateFormatter.string(from: date), for: .normal)
            
            
        }
        
    }
    func epCalendarPicker(_: EPCalendarPicker, didSelectMultipleDate dates : [Date]) {
        
        
    }

    
    
    @IBAction func hotel_search_location(_ sender: UIButton) {
        
        let searchController  = self.mainstoryboard.instantiateViewController(withIdentifier: "SearchingNames") as! SearchingNames
        
        if sender.tag == 0 {
            
            if checkManual == "manual"{
                self.check_data_type = "search_from_manual"

            }else{
                self.check_data_type = "travelportfrom"
            }
            

        }else {
            if checkManual == "manual"{
                self.check_data_type = "search_to_manual"
                
            }else{
                self.check_data_type = "travelportto"
            }
        }
        searchController.check = self.check_data_type
        navigationController?.pushViewController(searchController, animated: true)
        
    }
    
    func cabinDataTransferM(at tourInfo : TourInfo){
        
        self.tourInfo = tourInfo
        cabinData.setTitle("\((self.tourInfo?.adults)!) Adults, \((self.tourInfo?.child)!) Childs, \((self.tourInfo?.infants)!) Infants, \((self.tourInfo?.date)!)", for: .normal)
        
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       if segue.identifier == "show_travel_port"{
            
            let searching = segue.destination as! TravelPortListingView
            searching.tourInfo? = self.tourInfo!
            searching.hotelInfo? = self.hotelInfo
            
        } else if segue.identifier == "showCabinClass"{
            
            let searching = segue.destination as! CabinContorller
            searching.delegate = self
        
       }
        
    }
    
    
}



