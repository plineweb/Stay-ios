//
//  HotelRoomController.swift
//  memuDemo
//
//  Created by Qasim Hussain on 17/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import SVProgressHUD
import Toaster

class HotelRoomController: UIViewController,EPCalendarPickerDelegate{


    @IBOutlet weak var checkout_view: UIView!
    @IBOutlet weak var checkin_view: UIView!
    @IBOutlet weak var rooms: room_table!
    @IBOutlet weak var checkin: UILabel!
    @IBOutlet weak var checkOut: UILabel!
    var roomObject : Room_Model? = nil
    var check_date : String?
    var url  = ""
    var hotel_info : HotelInfo? = nil
    let dateFormatter = DateFormatter()

    var date_from : Date?


    var room_arry:[Room_Model] = []{
        didSet{

            self.rooms.controller = self
            
            if self.rooms.controller == nil {
            
                print("It is not nulled")
            
            }
            
            self.rooms.roomObject = room_arry
   
            
            checkin.text = hotel_info?.checkin
            checkOut.text = hotel_info?.checkout
            dateFormatter.dateFormat = "MM/dd/yyy"
            date_from = dateFormatter.date(from: (hotel_info?.checkin)!)
            date_from = date_from?.dateByAddingDays(1)

        }
   
    }
    
    @IBAction func update(_ sender: Any) {
        
        hotel_info?.checkin = checkin.text!
        hotel_info?.checkout = checkOut.text!
        
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Loading")
        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
        HotelDetailsRequest().getCarHotelDetails(hotel_info: self.hotel_info!) { (imageSlides,Amenities_arr,overview,payments,rooms,reviews,checkError,error)  in
            
            if error != ""{
                Toast.init(text: error).show()
            }else{
                self.rooms.roomObject = rooms
            }
            SVProgressHUD.dismiss()

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.CheckInClick(_:)))

        self.checkin_view.isUserInteractionEnabled = true

        self.checkin_view.addGestureRecognizer(tap)
        
        let tapOUt = UITapGestureRecognizer(target: self, action: #selector(self.CheckOUtClick(_:)))
        
        self.checkout_view.isUserInteractionEnabled = true
        
        self.checkout_view.addGestureRecognizer(tapOUt)
        
     
    }
    
    func CheckInClick(_ sender: UITapGestureRecognizer) {
        
        check_date = "CHECK IN"
        showDate(startDate: Date())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
   
        
        if segue.identifier == "show_webview"{
            
            let searching = segue.destination as! WebViewHomeController
            searching.url = self.url
            
        }else if segue.identifier == "show_invoice"{
            
            let searching = segue.destination as! InvoiceController
            searching.hotels_info = hotel_info
            searching.roomOb = roomObject
            searching.checkType = "hotels"
            
        }
        
        
        
    }
    
    func CheckOUtClick(_ sender: UITapGestureRecognizer) {
        
        check_date = "CHECK OUT"
        showDate(startDate: date_from!)
        
    }
    
    func  showDate(startDate : Date) -> Void {
        
        
        let calendarPicker = EPCalendarPicker(startYear: Date().year(), endYear: Date().year()+1, multiSelection: false, selectedDates: [])
        calendarPicker.calendarDelegate = self
        calendarPicker.startDate = startDate
        calendarPicker.hightlightsToday = false
        calendarPicker.hideDaysFromOtherMonth = true
        calendarPicker.dayDisabledTintColor = UIColor.gray
        calendarPicker.title = check_date
      
        
        let navigationController = UINavigationController(rootViewController: calendarPicker)
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
    func epCalendarPicker(_: EPCalendarPicker, didSelectDate date : Date) {
        
        if check_date == "CHECK IN"{
            
            dateFormatter.dateFormat = "MM/dd/yyy"

            checkin.text = dateFormatter.string(from: date)
            self.date_from = date.dateByAddingDays(1)
            checkOut.text = dateFormatter.string(from: date_from!)
            
            
        } else {
            dateFormatter.dateFormat = "MM/dd/yyy"
            checkOut.text = dateFormatter.string(from: date)

        }
        
    }
 
    func epCalendarPicker(_: EPCalendarPicker, didCancel error : NSError) {
        
    }
   

}
