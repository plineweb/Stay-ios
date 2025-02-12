//
//  MessageViewController.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class TourHomeController:  UIViewController,UINavigationBarDelegate,UINavigationControllerDelegate ,UITableViewDelegate,UITableViewDataSource,EPCalendarPickerDelegate {
    
    var tour_array:[AutoCompleteM] = []

    @IBOutlet weak var name_hotel_location: UIButton!
    @IBOutlet var tour_types: UITableView!
    @IBOutlet weak var topScreen: NSLayoutConstraint!
    
    @IBOutlet weak var tour_selected_types: UIButton!
    var myResponse : JSON = []


    
    
    @IBOutlet weak var poup_background: UILabel!
    @IBOutlet weak var bt_date_from: UIButton!
    
    var date_from_api : String?
    
    var decoded : Array<String> = []
    var tourinfo : TourInfo? = nil
    
    let preferences = UserDefaults.standard
    let searchkeyTours = "search_tour"
    var tour_type_id = "0"
    
    @IBOutlet var child_adult_tableview: UITableView!
    
    @IBOutlet weak var menu: UIBarButtonItem!
    
    var date_from : Date?
    
    @IBOutlet weak var adult: UIButton!

    let dateFormatter = DateFormatter()
    
    
    
    
    
    
    
    var adults = ["ADULT 1","ADULT 2","ADULT 3","ADULT 4","ADULT 5"]
    
    
    
    
    
    @IBOutlet weak var dateStack: UIStackView!
    
    
    
    @IBOutlet weak var rootStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        child_adult_tableview.layer.cornerRadius = 5
        tour_types.layer.cornerRadius = 5
        
        callToServer()
        
        
        if preferences.object(forKey: searchkeyTours) == nil {
            //  Doesn't exist
        } else {
            
            decoded  = preferences.array(forKey: searchkeyTours)! as! Array<String>
            name_hotel_location.setTitle(decoded[0], for: .normal)
        }
        
        date_from = Date()
        
        
        
        
        dateFormatter.dateFormat = "dd/MM/yyy"
        
        
        
        bt_date_from.setTitle(dateFormatter.string(from: date_from!), for: .normal)
        
        
        dateFormatter.dateFormat = "MM/dd/yyy"
        
        date_from_api = dateFormatter.string(from: date_from!)
        
        
        
        
        
        child_adult_tableview.dataSource = self
        child_adult_tableview.delegate = self
        
        tour_types.dataSource = self
        tour_types.delegate = self
        
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
        
        SVProgressHUD.dismiss()

        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        if preferences.object(forKey: searchkeyTours) == nil {
            //  Doesn't exist
        } else {
            
            decoded  = preferences.array(forKey: searchkeyTours)! as! Array<String>
            name_hotel_location.setTitle(decoded[0] , for: .normal)
        }
        
        
    }
    
    
    @IBAction func child_click(_ sender: UIButton) {
        
        child_adult_tableview.reloadData()

        animateInAdult()
    }
    
    
    @IBAction func hotel_search(_ sender: Any) {
        
        
        if self.decoded.count>0
        {
             tourinfo = TourInfo(id: decoded[2],
                                    location: name_hotel_location.currentTitle!,
                                    date: date_from_api!,
                                    adults: "\(adults.index(of: adult.title(for: .normal)!)!+1)"
                                   ,type: self.tour_type_id, child: "0", infants: "0")
            
            if self.decoded[1] == "location" {
                
                performSegue(withIdentifier: "show_list_page", sender: self)
            }else{
                performSegue(withIdentifier: "showToursDetails", sender: self)
            }
        }else {
            
            tourinfo = TourInfo(id: "0",
                                location: name_hotel_location.currentTitle!,
                                date: date_from_api!,
                                adults: "\(adults.index(of: adult.title(for: .normal)!)!+1)"
                ,type: self.tour_type_id, child: "0", infants: "0")
            performSegue(withIdentifier: "show_list_page", sender: self)
            
        }
        
}
    
    
    
    func animateInAdult() {
        self.view.addSubview(child_adult_tableview)
        child_adult_tableview.center = self.view.center
        
        child_adult_tableview.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        child_adult_tableview.alpha = 0
        poup_background.isHidden = false
        
        UIView.animate(withDuration: 0.4) {
            self.child_adult_tableview.alpha = 1
            self.child_adult_tableview.transform = CGAffineTransform.identity
        }
        
    }
    
    
    func animateOutAdult () {
        poup_background.isHidden = true
        
        UIView.animate(withDuration: 0.3, animations: {
            self.child_adult_tableview.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.child_adult_tableview.alpha = 0
            
            
        }) { (success:Bool) in
            self.child_adult_tableview.removeFromSuperview()
        }
    }
    
    
    func animateInTours() {
        self.view.addSubview(tour_types)
        tour_types.center = self.view.center
        
        tour_types.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        tour_types.alpha = 0
        poup_background.isHidden = false
        
        UIView.animate(withDuration: 0.4) {
            self.tour_types.alpha = 1
            self.tour_types.transform = CGAffineTransform.identity
        }
        
    }
    
    
    func animateOutTours () {
        poup_background.isHidden = true
        
        UIView.animate(withDuration: 0.3, animations: {
            self.tour_types.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.tour_types.alpha = 0
            
            
        }) { (success:Bool) in
            self.tour_types.removeFromSuperview()
        }
    }
    
    func callToServer()
    {
        let url : String = "\(Constant.domain)tours/tourtypes?appKey=\(Constant.key)"
        print(url)
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                self.myResponse=JSON(data)
                
                var mainArray = self.myResponse["response"]
                
                print(mainArray)
                for index in 0..<mainArray.count {
                    
                    var indexObject = mainArray[index]
                    let a = AutoCompleteM(name: indexObject["name"].stringValue,type:"",id: indexObject["id"].stringValue)
                    
                    self.tour_array.append(a)
                    
                    self.tour_types.reloadData()
                }
                
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.isEqual(tour_types)
        {
           return self.tour_array.count
        }else{
            return adults.count;

        
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=UITableViewCell()

        if tableView.isEqual(tour_types){
        
             cell.textLabel?.text=tour_array[indexPath.row].name
             self.tour_type_id = "\(tour_array[indexPath.row].id)"
            
        }else{
        
            cell.textLabel?.text=adults[indexPath.row]
        }
  
    
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.isEqual(tour_types)
        {
            tour_selected_types.setTitle(tour_array[indexPath.row].name, for: .normal)
            animateOutTours()
            
        }else
        {
            adult.setTitle(adults[indexPath.row], for: .normal)
            animateOutAdult()

        }
        
        
    }
    
    
    @IBAction func click_tour_type(_ sender: UIButton) {
        
        animateInTours()
        
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
        
            
            showDate(type: "",startDate: Date())
        
        
    }
    
    
    
    func  showDate(type : String , startDate : Date) -> Void {
        
        
        let calendarPicker = EPCalendarPicker(startYear: Date().year(), endYear: Date().year()+1, multiSelection: false, selectedDates: [])
        calendarPicker.calendarDelegate = self
        calendarPicker.startDate = startDate
        calendarPicker.hightlightsToday = false
        calendarPicker.showsTodaysButton = false
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
        
        
            dateFormatter.dateFormat = "dd/MM/yyy"
            bt_date_from.setTitle(dateFormatter.string(from: date), for: .normal)
 
             dateFormatter.dateFormat = "MM/dd/yyy"
        
            date_from_api = dateFormatter.string(from: date)

        
        
    }
    func epCalendarPicker(_: EPCalendarPicker, didSelectMultipleDate dates : [Date]) {
    }
    
    
    @IBAction func hotel_search_location(_ sender: Any) {
        
        performSegue(withIdentifier: "show_search_hotels", sender: self)
        print("fdfdfdfd")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "show_search_hotels"{

            let searching = segue.destination as! SearchingNames
            searching.check = "Tours"
        }else if segue.identifier == "show_list_page"{
            
            let listing = segue.destination as! HTC_ListingViewController
            listing.check = "Tours"
            listing.tour_search_data = self.tourinfo
        }
        else if segue.identifier == "showToursDetails"{
            
            let searching = segue.destination as! TourDetailsReq
            searching.tuor_info = self.tourinfo
        }
        
        
        
    }
    
    
}

