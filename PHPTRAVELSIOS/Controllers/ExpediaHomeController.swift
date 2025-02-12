//
//  MessageViewController.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit

class ExpediaHomeController:  UIViewController,UINavigationBarDelegate,UINavigationControllerDelegate ,UITableViewDelegate,UITableViewDataSource,EPCalendarPickerDelegate {
    
    
    @IBOutlet weak var name_hotel_location: UIButton!
    @IBOutlet weak var topScreen: NSLayoutConstraint!
    
    
    @IBOutlet weak var poup_background: UILabel!
    @IBOutlet weak var bt_date_from: UIButton!
    @IBOutlet weak var bt_date_to: UIButton!
    
    var date_from_api : String?
    var date_to_api : String?
    var id : String = ""
    
    var decoded : Array<String> = []
    
    let preferences = UserDefaults.standard
    
    @IBOutlet var child_adult_tableview: UITableView!
    let searchkeyExpedia = "search_expedia"

    @IBOutlet weak var menu: UIBarButtonItem!
    
    @IBOutlet weak var adult: UIButton!
    var date_from : Date?
    
    @IBOutlet weak var child: UIButton!
    var date_to : Date?
    var hotel_info : ExpediaModel? = nil
    let dateFormatter = DateFormatter()
    
    
    var check_date : String?
    
    var check_child : Bool?
    
    
    
    var childs = ["CHILD 0","CHILD 1","CHILD 2","CHILD 3","CHILD 4"]
    
    var adults = ["ADULT 1","ADULT 2","ADULT 3","ADULT 4","ADULT 5"]
    
    
    
    
    
    @IBOutlet weak var dateStack: UIStackView!
    
    
    
    @IBOutlet weak var rootStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        child_adult_tableview.layer.cornerRadius = 5
        
        
        
        if preferences.object(forKey: searchkeyExpedia) == nil {
            
            
        } else {
            
            decoded  = preferences.array(forKey: searchkeyExpedia)! as! Array<String>
            name_hotel_location.setTitle(decoded[0], for: .normal)
            self.id = decoded[2]
        }
        
        date_to = Date()
        
        date_from = Date()
        
        
        
        
        dateFormatter.dateFormat = "dd/MM/yyy"
        
        
        
        bt_date_from.setTitle(dateFormatter.string(from: date_from!), for: .normal)
        bt_date_to.setTitle(dateFormatter.string(from: (date_to?.dateByAddingDays(1))!), for: .normal)
        
        
        dateFormatter.dateFormat = "MM/dd/yyy"
        
        date_from_api = dateFormatter.string(from: date_from!)
        
        date_to_api = dateFormatter.string(from: (date_to?.dateByAddingDays(1))!)
        
        
        
        
        child_adult_tableview.dataSource = self
        child_adult_tableview.delegate = self
        
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
        
        
        if preferences.object(forKey: searchkeyExpedia) == nil {
            //  Doesn't exist
        } else {
            
            decoded  = preferences.array(forKey: searchkeyExpedia)! as! Array<String>
            name_hotel_location.setTitle(decoded[0] , for: .normal)
        }
        
        
    }
    
    
    @IBAction func child_click(_ sender: UIButton) {
        
        if sender.tag == 0{
            check_child = true
        }
        else{
            check_child = false
            
        }
        child_adult_tableview.reloadData()
        animateIn()
    }
    
    
    @IBAction func hotel_search(_ sender: Any) {
        
        
        if self.decoded.count>0
        {
            self.hotel_info = ExpediaModel(id: self.id,child: "\(childs.index(of: child.title(for: .normal)!)!)", adult: "\(adults.index(of: adult.title(for: .normal)!)!+1)", checkin: date_from_api!, checkout: date_to_api!, customerSessionId: "", ratekey: "", rateCode: "", roomType: "")
            
                performSegue(withIdentifier: "show_list_page", sender: self)
            
        }else {
            
            self.hotel_info = ExpediaModel(id: self.id,child: "\(childs.index(of: child.title(for: .normal)!)!)", adult: "\(adults.index(of: adult.title(for: .normal)!)!+1)", checkin: date_from_api!, checkout: date_to_api!, customerSessionId: "", ratekey: "", rateCode: "", roomType: "")
            performSegue(withIdentifier: "show_list_page", sender: self)
            
        }
  
    }
    
    
    
    func animateIn() {
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
    
    
    func animateOut () {
        poup_background.isHidden = true
        
        UIView.animate(withDuration: 0.3, animations: {
            self.child_adult_tableview.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.child_adult_tableview.alpha = 0
            
            
        }) { (success:Bool) in
            self.child_adult_tableview.removeFromSuperview()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return childs.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=UITableViewCell()
        if check_child == true{
            cell.textLabel?.text=adults[indexPath.row]
        } else{
            cell.textLabel?.text=childs[indexPath.row]
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if check_child == true
        {
            
            adult.setTitle(adults[indexPath.row], for: .normal)
        }else{
            child.setTitle(childs[indexPath.row], for: .normal)
            
        }
        animateOut()
        
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
        calendarPicker.dayDisabledTintColor = UIColor.gray
        calendarPicker.title = "CHECK IN"

        
        let navigationController = UINavigationController(rootViewController: calendarPicker)
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
    
    
    
    func epCalendarPicker(_: EPCalendarPicker, didCancel error : NSError) {
        
    }
    func epCalendarPicker(_: EPCalendarPicker, didSelectDate date : Date) {
        
        if check_date == "in"{
            
            dateFormatter.dateFormat = "dd/MM/yyy"
            bt_date_from.setTitle(dateFormatter.string(from: date), for: .normal)
            bt_date_to.setTitle(dateFormatter.string(from: date.dateByAddingDays(1)), for: .normal)
            date_to = date
            
        } else {
            
            date_to = date
            bt_date_to.setTitle(dateFormatter.string(from: date), for: .normal)
            
            
        }
        
    }
    func epCalendarPicker(_: EPCalendarPicker, didSelectMultipleDate dates : [Date]) {
    }
    
    
    @IBAction func hotel_search_location(_ sender: Any) {
        
        performSegue(withIdentifier: "show_search_hotels", sender: self)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "show_search_hotels"{
            let searching = segue.destination as! SearchingNames
            searching.check = "expedia"
        } else if segue.identifier == "show_list_page"{
            
            let listing = segue.destination as! HTC_ListingViewController
            listing.check = "expedia"
            listing.expedia_info = self.hotel_info
        }
    }
}

public extension UIView {
    public func pin(to view: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}
