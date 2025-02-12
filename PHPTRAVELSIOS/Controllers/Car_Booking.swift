//
//  Car_Booking.swift
//  memuDemo
//
//  Created by Qasim Hussain on 28/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import APJTextPickerView
import Toaster

class Car_Booking: UIViewController, APJTextPickerViewDelegate, APJTextPickerViewDataSource,EPCalendarPickerDelegate,DPTimePickerDelegate {
    
    
    @IBOutlet weak var booking_view: CardView!
    @IBOutlet weak var total_price: UILabel!
    @IBOutlet weak var dropoff_time_click: UIButton!

    var pickup_obj : AutoCompleteM? = nil
    var drop_obj :  AutoCompleteM? = nil
    var url = ""
    
    @IBOutlet weak var pickup_time: UIButton!
    @IBOutlet weak var deposite_price: UILabel!
    @IBOutlet weak var tax_and_vat: UILabel!
    @IBOutlet weak var pickup_locations: APJTextPickerView!
    @IBOutlet weak var dropoff_time: UIButton!
    @IBOutlet weak var dropoff_date: UIButton!
    @IBOutlet weak var dropOffLocations: APJTextPickerView!
    var check_date : String?
    @IBOutlet weak var pikup_date: UIButton!

    let timePicker: DPTimePicker = DPTimePicker.timePicker()

    var checkTime : String = ""
    var date_to : Date?


    let dateFormatter = DateFormatter()


    var checkType : String = ""
    
    var car_info : CarInfo? = nil {
        didSet{
           
            date_to = Date().dateByAddingDays(1)
            self.pikup_date.setTitle(car_info?.checkin,for: .normal)
            self.dropoff_date.setTitle(car_info?.checkout,for: .normal)
            self.pickup_time.setTitle(car_info?.check_in_time,for: .normal)
            self.dropoff_time.setTitle(car_info?.check_to_time,for : .normal)
            


            if car_info?.id_from == "0" || car_info?.id_to == "0" {
                
                
                booking_view.isHidden = true
                pickup_locations.text = "Location From"
                dropOffLocations.text = "Location To"
            }else{
            
                for i in 0..<pickup_array.count {
                
                    if "\(pickup_array[i].id)" == car_info?.id_from{
                    pickup_locations.text = pickup_array[i].name
                        
                        pickup_obj = pickup_array[i]
                        
                    }
                
                }
            
                for i in 0..<drop_off_array.count {
                    
                    if "\(drop_off_array[i].id)" == car_info?.id_to{
                        dropOffLocations.text = drop_off_array[i].name
                        drop_obj = drop_off_array[i]
                    }
                    
                }
                
                total_price.text = car_info?.total_cast
                tax_and_vat.text = car_info?.total_TaxPrice
                deposite_price.text = car_info?.total_Deposite
                
                
            }

        }
    }
    
    var pickup_array:[AutoCompleteM] = []{
        didSet{
            
            checkType = "pikup"
            pickup_locations.type = .strings
            pickup_locations.pickerDelegate = self
            pickup_locations.dataSource = self
            
        }
    }
    
    var drop_off_array:[AutoCompleteM] = []{
        didSet{
            
            checkType = "dropoff"
            dropOffLocations.type = .strings
            dropOffLocations.pickerDelegate = self
            dropOffLocations.dataSource = self
        }
    }
    
    @IBAction func dropOff_time_click(_ sender: UIButton) {
        checkTime = "to"
        timePicker.show(nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
    }

    @IBAction func dropoff_date_click(_ sender: UIButton) {
        
        check_date = "out"
        date_to = date_to?.dateByAddingDays(1)
        showDate(type: "",startDate: date_to!)
    
    }

    @IBAction func pickup_time_click(_ sender: UIButton) {
        checkTime = "from"
        timePicker.show(nil)
    }
    
    @IBAction func update(_ sender: Any) {
        
        CarRequest().getCarDetails(car_info: self.car_info!) { (imageSlides,overview,payments,pickup_array,dropoff_array,carinfo,error)  in
            
            if error != ""{
                
                Toast.init(text : error).show()
                
            }else{
                self.booking_view.isHidden = false
                self.total_price.text = carinfo.total_cast
                self.tax_and_vat.text = carinfo.total_TaxPrice
                self.deposite_price.text = carinfo.total_Deposite
                
            }
       
            
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    @IBAction func book(_ sender: Any) {
        
        
        
        self.car_info?.check_in_time = pickup_time.title(for : .normal)!
        self.car_info?.check_to_time = dropoff_time.title(for : .normal)!

        self.car_info?.checkin = pikup_date.title(for : .normal)!
        self.car_info?.checkout = dropoff_date.title(for : .normal)!
        
        self.car_info?.id_from = "\(pickup_obj!.id)"
        self.car_info?.id_to = "\(drop_obj!.id)"
        
        if CommonMethods.preferences.object(forKey: "login") == nil ||  CommonMethods.checkCoupon{
            
            self.performSegue(withIdentifier: "show_invoice", sender: self)
            
        } else {
            
            let user : [String] =  CommonMethods.preferences.array(forKey: "login") as! [String]
            
            let pro = HotelInfo(id : "",child : "",adult : "" ,checkin : "", checkout : "")
            
            
            CarBookingRequest().CarBooking(guest: "", profile: pro, coupon_id: "0", id : user[2],car_info : self.car_info!) { (result,error) in
                
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
    
    func timePickerDidConfirm(_ hour: String, minute: String, timePicker: DPTimePicker) {
        
        if checkTime == "from"{
            
          pickup_time.setTitle("\(hour) : \(minute)", for: .normal)
            
        }else{
            
             dropoff_time.setTitle("\(hour) : \(minute)", for: .normal)
            
        }
        
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
    
    func timePickerDidClose(_ timePicker: DPTimePicker) {
        
    }

    
    
    func epCalendarPicker(_: EPCalendarPicker, didCancel error : NSError) {
        
    }
    func epCalendarPicker(_: EPCalendarPicker, didSelectDate date : Date) {
        
        if check_date == "in"{
            
            dateFormatter.dateFormat = "MM/dd/yyy"
            pikup_date.setTitle(dateFormatter.string(from: date), for: .normal)
            dropoff_date.setTitle(dateFormatter.string(from: date.dateByAddingDays(1)), for: .normal)
            date_to = date
            
        } else {
            
            dateFormatter.dateFormat = "MM/dd/yyy"
            date_to = date
            dropoff_date.setTitle(dateFormatter.string(from: date), for: .normal)
            
            
        }
        
    }
    func epCalendarPicker(_: EPCalendarPicker, didSelectMultipleDate dates : [Date]) {
        
        
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
    
    @IBAction func pickup_date_click(_ sender: UIButton) {
        check_date = "in"
        showDate(type: "",startDate: date_to!)
    }
    func textPickerView(_ textPickerView: APJTextPickerView, didSelectString row: Int) {
    }
    
    func textPickerView(_ textPickerView: APJTextPickerView, titleForRow row: Int) -> String? {
        
        if textPickerView.tag == 0{
            
            pickup_obj = pickup_array[row]
            return pickup_array[row].name

        }else {
            
            drop_obj = drop_off_array[row]
            
            return drop_off_array[row].name

        }
        
    }
    func numberOfRows(in pickerView: APJTextPickerView) -> Int {
        
        
        if pickerView.tag == 0{
            
            return pickup_array.count

        }else {
            return drop_off_array.count
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_webview"{
            
            let searching = segue.destination as! WebViewHomeController
            searching.url = self.url
            
        }else if segue.identifier == "show_invoice"{
            
            let searching = segue.destination as! InvoiceController
            searching.cars_info = self.car_info
            searching.checkType = "cars"
            
        }
    }
    
}




