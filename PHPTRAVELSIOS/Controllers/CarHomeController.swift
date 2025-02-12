//
//  MessageViewController.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit
import SVProgressHUD

class CarHomeController: UIViewController,UINavigationBarDelegate,UINavigationControllerDelegate ,EPCalendarPickerDelegate,DPTimePickerDelegate {
    
    
    @IBOutlet weak var location_from: UIButton!
    
    @IBOutlet weak var location_to: UIButton!
    @IBOutlet weak var topScreen: NSLayoutConstraint!
    
    
  
    
    @IBOutlet weak var bt_date_from: UIButton!
    @IBOutlet weak var bt_date_to: UIButton!
    
    @IBOutlet weak var time_from: UIButton!
    @IBOutlet weak var time_to: UIButton!
    
    var checkTime : String = ""
    
    var check_data_type : String = ""
    
    var date_from_api : String?
    var date_to_api : String?
    var id_from : String = "0"
    var id_to : String = "0"
    let timePicker: DPTimePicker = DPTimePicker.timePicker()

    
    var decoded : Array<String> = []
    
    let preferences = UserDefaults.standard
    let searchkeyCarsFrom = "search_car_from"
    let searchkeyCarsTo = "search_car_to"
    
    @IBAction func TimeClickFrom(_ sender: Any) {
    }
    
    
    @IBOutlet weak var menu: UIBarButtonItem!
    
    var date_from : Date?
    
    var date_to : Date?
    var car_info : CarInfo? = nil
    let dateFormatter = DateFormatter()
    
    
    var check_date : String?
    

    @IBOutlet weak var dateStack: UIStackView!
    
    
    
    @IBOutlet weak var rootStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
    
 
        date_to = Date()
        
        date_from = Date()
        
        
        
        
        dateFormatter.dateFormat = "dd/MM/yyy"
        
        
        
        bt_date_from.setTitle(dateFormatter.string(from: date_from!), for: .normal)
        bt_date_to.setTitle(dateFormatter.string(from: (date_to?.dateByAddingDays(1))!), for: .normal)
        
        
        dateFormatter.dateFormat = "MM/dd/yyy"
        
        date_from_api = dateFormatter.string(from: date_from!)
        
        date_to_api = dateFormatter.string(from: (date_to?.dateByAddingDays(1))!)
        
        time_from.setTitle("\(Date().hour()):\(Date().minute())", for: .normal)
        time_to.setTitle("\(Date().hour()):\(Date().minute())", for: .normal)

        
        
        // Time Picker Setting
        
        timePicker.insertInView(view)
        timePicker.delegate = self
        timePicker.closeButton.setTitleColor(hexStringToUIColor(hex: "#2E3192"), for: .normal)
        timePicker.closeButton.setTitle("Close", for: .normal)
        timePicker.okButton.setTitleColor(hexStringToUIColor(hex: "#2E3192"), for: .normal)
        timePicker.okButton.setTitle("OK", for: .normal)
        timePicker.backgroundColor = hexStringToUIColor(hex: "#2E3192")
        timePicker.numbersColor = UIColor.white
        timePicker.linesColor = UIColor.white
        timePicker.pointsColor = UIColor.white
        timePicker.topGradientColor = hexStringToUIColor(hex: "#2E3192")
        timePicker.bottomGradientColor = hexStringToUIColor(hex: "#2E3192")
        timePicker.fadeAnimation = true
        timePicker.springAnimations = true
        timePicker.scrollAnimations = true
        timePicker.areLinesHidden = false
        timePicker.arePointsHidden = false
        timePicker.initialHour = "15"
        timePicker.initialMinute = "12"
        
        // End Time Picker

        
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
    
    @IBAction func TimeFromClick(_ sender: Any) {
        
        checkTime = "from"
        timePicker.show(nil)
        

        
    }
    @IBAction func time_click_to(_ sender: Any) {
        
        checkTime = "to"
        timePicker.show(nil)
        
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        SVProgressHUD.dismiss()

        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        if preferences.object(forKey: searchkeyCarsFrom) == nil {
            
            
        } else {
            
            decoded  = preferences.array(forKey: searchkeyCarsFrom)! as! Array<String>
            location_from.setTitle(decoded[0], for: .normal)
            self.id_from = decoded[2]
        }
        if preferences.object(forKey: searchkeyCarsTo) == nil {
            
            
        } else {
            
            decoded  = preferences.array(forKey: searchkeyCarsTo)! as! Array<String>
            location_to.setTitle(decoded[0], for: .normal)
            self.id_to = decoded[2]
        }
        
    }
    
    
    
    @IBAction func hotel_search(_ sender: Any) {
        
        
        if self.decoded.count>0
        {
            self.car_info = CarInfo(id_from: self.id_from, id_to: self.id_to, checkin: date_from_api!, checkout: date_to_api!, check_in_time: time_to.title(for: .normal)!, check_to_time: time_from.title(for: .normal)!)
            
            if self.decoded[1] == "location" {
                
                performSegue(withIdentifier: "show_list_page", sender: self)
                
                
            }
        }else {
            
          self.car_info = CarInfo(id_from: self.id_from, id_to: self.id_to, checkin: date_from_api!, checkout: date_to_api!, check_in_time: time_to.title(for: .normal)!, check_to_time: time_from.title(for: .normal)!)
            performSegue(withIdentifier: "show_list_page", sender: self)
            
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
            
            
            check_date = "out"
            date_to = date_to?.dateByAddingDays(1)
            showDate(type: "",startDate: date_to!)
            
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
            dateFormatter.dateFormat = "MM/dd/yyy"
            date_from_api = dateFormatter.string(from: date)
            self.date_from = date.dateByAddingDays(1)
            dateFormatter.dateFormat = "dd/MM/yyy"
            bt_date_to.setTitle(dateFormatter.string(from: date.dateByAddingDays(1)), for: .normal)
            dateFormatter.dateFormat = "MM/dd/yyy"
            date_to_api = dateFormatter.string(from: date.dateByAddingDays(1))
            
        } else {
            
            dateFormatter.dateFormat = "MM/dd/yyy"
            date_to_api = dateFormatter.string(from: date)
            
            dateFormatter.dateFormat = "dd/MM/yyy"
            bt_date_to.setTitle(dateFormatter.string(from: date), for: .normal)
        }
        
    }
    func epCalendarPicker(_: EPCalendarPicker, didSelectMultipleDate dates : [Date]) {
        
        
    }
    
    
    @IBAction func hotel_search_location(_ sender: UIButton) {
        
        
        if sender.tag == 0 {
        
          self.check_data_type = "CarFrom"
            
        }else {
            
           self.check_data_type = "CarTo"
        }
        print(self.check_data_type)
        performSegue(withIdentifier: "show_search_hotels", sender: self)
        
        
        
    }
    
    func timePickerDidConfirm(_ hour: String, minute: String, timePicker: DPTimePicker) {
      
        if checkTime == "from"{
            
            time_from.setTitle("\(hour) : \(minute)", for: .normal)
        
        }else{
            
            time_to.setTitle("\(hour) : \(minute)", for: .normal)
        
        }
        
    }
    
    func timePickerDidClose(_ timePicker: DPTimePicker) {
        
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "show_search_hotels"{
            
            let searching = segue.destination as! SearchingNames
            searching.check = self.check_data_type
            
            print(self.check_data_type)
        
        } else if segue.identifier == "show_list_page"{
            
            let listing = segue.destination as! HTC_ListingViewController
            listing.check = "Cars"
            listing.car_search_data = self.car_info
        }
        
        
    }
    
    
}



