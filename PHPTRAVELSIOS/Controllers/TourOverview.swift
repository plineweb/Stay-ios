//
//  TourOverview.swift
//  memuDemo
//
//  Created by Qasim Hussain on 21/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster

class TourOverview: UIViewController ,EPCalendarPickerDelegate {

    @IBOutlet weak var priceHeader: UIView!
    
    @IBOutlet weak var plusInfants: UIImageView!
    @IBOutlet weak var minusInfants: UIImageView!
    @IBOutlet weak var childMinus: UIImageView!
    @IBOutlet weak var childPlus: UIImageView!
    @IBOutlet weak var AdultsView: UIView!
    @IBOutlet weak var child_views: UIView!
    @IBOutlet weak var infants_view: UIView!
    @IBOutlet weak var describtions: UILabel!
    
    @IBOutlet weak var date_click: UIView!
    
    @IBOutlet weak var check_out: UILabel!
    
    var url : String = ""
    
    var tour_info : TourInfo? = nil{
    
        didSet{
            print("Check Change")
          self.check_out.text = tour_info?.date
            
        }
        
    
    }
    
    @IBOutlet weak var adults_value_view: UIView!
    
    @IBOutlet weak var child_value_view: UIView!

    @IBOutlet weak var infants_value_view: UIView!

    @IBOutlet weak var policy: UILabel!
    let dateFormatter = DateFormatter()
    @IBOutlet weak var minusChild: UIImageView!
    @IBOutlet weak var plusChild: UIImageView!
    @IBOutlet weak var plusAdults: UIImageView!
    @IBOutlet weak var minusAdults: UIImageView!

    
    @IBOutlet weak var adultstxt: UILabel!
    @IBOutlet weak var childtxt: UILabel!
    @IBOutlet weak var inflantstxt: UILabel!
    
    
    @IBOutlet weak var payments: AmenitiesCollection!
    @IBOutlet weak var numberOfAdults: UILabel!
    @IBOutlet weak var numberOfChilds: UILabel!
    @IBOutlet weak var numberOfInflants: UILabel!
    
    
    @IBOutlet weak var priceAdults: UILabel!
    @IBOutlet weak var priceChilds: UILabel!
    @IBOutlet weak var priceInflants: UILabel!

    
    
    
    var payments_arry:[NameImage] = []{
        didSet{
           payments.mainArray = payments_arry
            
            
        }
        
    }
    
    
    var overView : Tour_Overview? = nil {
        didSet{
            
            self.adultstxt.text = "Adults \((overView?.currSumbol)!) \((overView?.perAdultPrice)!)"
            self.childtxt.text = "Childs \((overView?.currSumbol)!) \((overView?.perChildPrice)!)"
            self.inflantstxt.text = "Inflants \((overView?.currSumbol)!) \((overView?.perInfantPrice)!)"
            self.describtions.text = " \((overView?.desc)!)"
            
            self.policy.text = "\((overView?.policy)!)"
            


            let adultprice = Float((overView?.adultPrice.replacingOccurrences(of: ",", with: "",options: NSString.CompareOptions.literal, range:nil))!)
            let perAdultPrice = Float((overView?.perAdultPrice.replacingOccurrences(of: ",", with: ""))!)
            let perChildPrice = Float((overView?.perChildPrice.replacingOccurrences(of: ",", with: ""))!)
            let childPrice = Float((overView?.childPrice.replacingOccurrences(of: ",", with: ""))!)
            let infantPrice = Float((overView?.infantPrice.replacingOccurrences(of: ",", with: ""))!)
            let perInfantPrice = Float((overView?.perInfantPrice.replacingOccurrences(of: ",", with: ""))!)
            overView?.adultPrice = "\(adultprice!)"
            overView?.perAdultPrice = "\(perAdultPrice!)"
            overView?.perChildPrice = "\(perChildPrice!)"
            overView?.childPrice = "\(childPrice!)"
            overView?.infantPrice = "\(infantPrice!)"
            overView?.perInfantPrice = "\(perInfantPrice!)"

            self.numberOfAdults.text = "\(Int((adultprice!) / (perAdultPrice!)))"
            self.numberOfChilds.text = "\(Int((childPrice!) / (perChildPrice!)))"
            self.numberOfInflants.text = "\(Int((infantPrice!) / (perInfantPrice!)))"

            if overView?.childStatus == "0"
            {
                
              child_views.isHidden = true
                
            }else{
            
                child_views.isHidden = false
            }
            
            if overView?.infantStatus == "0"
            {
                
                infants_view.isHidden = true
                
            }else{
                
                infants_view.isHidden = false
            }
            
            self.priceAdults.text = "\((overView?.currSumbol)!) \((overView?.adultPrice)!)"
            self.priceChilds.text = "\((overView?.currSumbol)!) \((overView?.childPrice)!)"
            self.priceInflants.text = "\((overView?.currSumbol)!) \((overView?.infantPrice)!)"
            

            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.priceHeader.layer.borderWidth = 0.5
        self.priceHeader.layer.borderColor = hexStringToUIColor(hex: "#eeee").cgColor
        
 
        self.adults_value_view.layer.borderWidth = 0.5
        self.adults_value_view.layer.cornerRadius = 5
        self.adults_value_view.layer.borderColor = hexStringToUIColor(hex: "#eeee").cgColor
        
        self.child_value_view.layer.borderWidth = 0.5
        self.child_value_view.layer.cornerRadius = 5
        self.child_value_view.layer.borderColor = hexStringToUIColor(hex: "#eeee").cgColor
        
        
        self.infants_value_view.layer.borderWidth = 0.5
        self.infants_value_view.layer.cornerRadius = 5
        self.infants_value_view.layer.borderColor = hexStringToUIColor(hex: "#eeee").cgColor
        
   
        

        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(TourOverview.plusAdult))
        singleTap.numberOfTapsRequired = 1
        plusAdults.isUserInteractionEnabled = true
        plusAdults.addGestureRecognizer(singleTap)
        
        let minusClickAdults = UITapGestureRecognizer(target: self, action: #selector(TourOverview.minusAdult))
        singleTap.numberOfTapsRequired = 1
        minusAdults.isUserInteractionEnabled = true
        minusAdults.addGestureRecognizer(minusClickAdults)
        
        let plusClicksChilds = UITapGestureRecognizer(target: self, action: #selector(TourOverview.plusChilds))
        singleTap.numberOfTapsRequired = 1
        plusChild.isUserInteractionEnabled = true
        plusChild.addGestureRecognizer(plusClicksChilds)
        
        let minusClicksChilds = UITapGestureRecognizer(target: self, action: #selector(TourOverview.minusChilds))
        singleTap.numberOfTapsRequired = 1
        minusChild.isUserInteractionEnabled = true
        minusChild.addGestureRecognizer(minusClicksChilds)
        
        let plusClicksInfants = UITapGestureRecognizer(target: self, action: #selector(TourOverview.plusInfantsMethod))
        singleTap.numberOfTapsRequired = 1
        plusInfants.isUserInteractionEnabled = true
        plusInfants.addGestureRecognizer(plusClicksInfants)
        
        let minusClicksInfants = UITapGestureRecognizer(target: self, action: #selector(TourOverview.minusInfantsMethod))
        singleTap.numberOfTapsRequired = 1
        minusInfants.isUserInteractionEnabled = true
        minusInfants.addGestureRecognizer(minusClicksInfants)
        
        let DateClick = UITapGestureRecognizer(target: self, action: #selector(TourOverview.ChnageDate))
        date_click.isUserInteractionEnabled = true
        date_click.addGestureRecognizer(DateClick)
    
    }
    
    func  showDate(startDate : Date) -> Void {
        
        
        let calendarPicker = EPCalendarPicker(startYear: Date().year(), endYear: Date().year()+1, multiSelection: false, selectedDates: [])
        calendarPicker.calendarDelegate = self
        calendarPicker.startDate = startDate
        calendarPicker.hightlightsToday = false
        calendarPicker.hideDaysFromOtherMonth = true
        //        calendarPicker.barTintColor = UIColor.greenColor()
        calendarPicker.dayDisabledTintColor = UIColor.gray
        calendarPicker.title = "Date"
        calendarPicker.hightlightsToday = false
        
        
        //        calendarPicker.backgroundImage = UIImage(named: "background_image")
        //        calendarPicker.backgroundColor = UIColor.blueColor()
        
        let navigationController = UINavigationController(rootViewController: calendarPicker)
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
    func epCalendarPicker(_: EPCalendarPicker, didSelectDate date : Date) {
        

            
            dateFormatter.dateFormat = "MM/dd/yyy"
            check_out.text = dateFormatter.string(from: date)

        
    }
    
    func epCalendarPicker(_: EPCalendarPicker, didCancel error : NSError) {
        
    }
    
    //Action
    @objc func plusAdult() {

        let maxInt : Int = Int((overView?.maxChild)!)!
        
        let current : Int = Int((self.numberOfAdults.text)!)!
        
        if current < maxInt {
        
            self.numberOfAdults.text = "\(current+1)"
            self.priceAdults.text = "\((overView?.currSumbol)!) \(Float(self.numberOfAdults.text!)!*Float((overView?.perAdultPrice)!)!)"
        
        }
    }

    @objc func minusAdult() {
        
        let current : Int = Int((self.numberOfAdults.text)!)!
        
        if current > 1 {
            
            self.numberOfAdults.text = "\(current-1)"
            self.priceAdults.text = "\((overView?.currSumbol)!) \(Float(self.numberOfAdults.text!)!*Float((overView?.perAdultPrice)!)!)"
            
        }
    }
    
    @objc func plusChilds() {
        
        let maxInt : Int = Int((overView?.maxChild)!)!
        
        let current : Int = Int((self.numberOfChilds.text)!)!
        
        if current < maxInt {
            
            self.numberOfChilds.text = "\(current+1)"
            self.priceChilds.text = "\((overView?.currSumbol)!) \(Float(self.numberOfChilds.text!)!*Float((overView?.perChildPrice)!)!)"
            
        }
    }
    
    @objc func minusChilds() {
        
        let current : Int = Int((self.numberOfChilds.text)!)!
        
        if current > 0 {
            
            self.numberOfChilds.text = "\(current-1)"
            self.priceChilds.text = "\((overView?.currSumbol)!) \(Float(self.numberOfChilds.text!)!*Float((overView?.perChildPrice)!)!)"
            
        }
    }
    
    @objc func ChnageDate() {
   
        showDate(startDate:Date())
   
    }

    
    @IBAction func BookIt(_ sender: UIButton) {
        
        
        tour_info?.adults = numberOfAdults.text!
        tour_info?.child = numberOfChilds.text!
        tour_info?.infants = numberOfInflants.text!
        tour_info?.date = self.check_out.text!
        
        if CommonMethods.preferences.object(forKey: "login") == nil ||  CommonMethods.checkCoupon{
            
            
            self.performSegue(withIdentifier: "show_invoice", sender: self)
            
        } else {
            
            let user : [String] =  CommonMethods.preferences.array(forKey: "login") as! [String]
            
            var pro = HotelInfo(id : "",child : "",adult : "" ,checkin : "", checkout : "")

            
            TourBookingRequest().TourBookingLogin(guest: "", profile: pro, coupon_id: "0", id : user[2],tour_info : self.tour_info!) { (result,error) in
               
                if error != ""{
                    
                    Toast.init(text: error).show()
                    
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
    @objc func plusInfantsMethod() {
        
        let maxInt : Int = Int((overView?.maxChild)!)!
        
        let current : Int = Int((self.numberOfInflants.text)!)!
        
        if current < maxInt {
            
            self.numberOfInflants.text = "\(current+1)"
            self.priceInflants.text = "\((overView?.currSumbol)!) \(Float(self.numberOfInflants.text!)!*Float((overView?.perInfantPrice)!)!)"
            
        }
    }
    
    @objc func minusInfantsMethod() {
        
        let current : Int = Int((self.numberOfInflants.text)!)!
        
        if current > 0 {
            
            self.numberOfInflants.text = "\(current-1)"
            self.priceInflants.text = "\((overView?.currSumbol)!) \(Float(self.numberOfInflants.text!)!*Float((overView?.perInfantPrice)!)!)"
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_webview"{
            
            let searching = segue.destination as! WebViewHomeController
            searching.url = self.url
            
        }else if segue.identifier == "show_invoice"{
            
            let searching = segue.destination as! InvoiceController
            searching.tour_info = tour_info
            searching.checkType = "tours"
           
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

}
