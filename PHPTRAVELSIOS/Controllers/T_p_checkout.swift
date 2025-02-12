//
//  T_p_checkout.swift
//  memuDemo
//
//  Created by Qasim Hussain on 05/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster
import SVProgressHUD

class T_p_checkout: UIViewController {


    @IBOutlet weak var pass_tb_height: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var departure_table: Tp_tb_checkout_table!

    @IBOutlet weak var return_view: UIView!
    @IBOutlet weak var return_table: Tp_tb_checkout_table!
    @IBOutlet weak var departure_view_height: NSLayoutConstraint!
    @IBOutlet weak var pass_table: Passenger!
    @IBOutlet weak var tavelinfo_height: NSLayoutConstraint!
    @IBOutlet weak var traveler_info: UIView!
    @IBOutlet weak var details_view_height: NSLayoutConstraint!
    @IBOutlet weak var total_amount: UILabel!
    @IBOutlet weak var taxes: UILabel!
    @IBOutlet weak var base_rate: UILabel!
    @IBOutlet weak var depar: UILabel!
    @IBOutlet weak var company_name: UILabel!
    @IBOutlet weak var company_img: UIImageView!
    @IBOutlet weak var show_view: UIView!
        let dateFormatter = DateFormatter()
    var inbound_details : [Tp_details_checkout] = []
    var outbound_details : [Tp_details_checkout] = []

    
    var tourInfo : TourInfo? = TourInfo(id : "",location: "", date: "",adults: "",type: "",child : "",infants : "")
    
    var outbound_rec : [TravelPortDetails] = []
    var inbound_rec : [TravelPortDetails] = []
    var pas_arr : [PasssengerModel] = []
    var pas_arr_book : [PasssengerModel] = []

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.navigationController?.navigationBar.tintColor = UIColor.white

        var passenger = PasssengerModel()

        var ab : Int = Int(tourInfo!.adults)!
        for i in 0..<ab {
        
            passenger = PasssengerModel()
            passenger.p_title = "\(i+1)-Adult"
            pas_arr.append(passenger)
            
        }
        ab = Int(tourInfo!.infants)!
        for i in 0..<ab{
            
            passenger = PasssengerModel()
            passenger.p_title = "\(i+1)-Infant"
            pas_arr.append(passenger)
            
            
        }
        ab = Int(tourInfo!.child)!
        for i in 0..<ab{
            
            passenger = PasssengerModel()
            passenger.p_title = "\(i+1)-Child"
            pas_arr.append(passenger)
        }
        
        pass_table.pass_arr = pas_arr
        
       self.tavelinfo_height.constant = CGFloat(((pas_arr.count * 350)+70))
        
        
        
        var p : [String:String] = [:]

        if inbound_rec.count != 0{
        
            var s = ""
            for i in 0..<inbound_rec.count{
            
                s.append("\(inbound_rec[i].key),")
            }
            s = String(s.characters.dropLast())
            p.updateValue(s, forKey: "inbound")
            
        }
        
        var s = ""
        for i in 0..<outbound_rec.count{
            
            s.append("\(outbound_rec[i].key),")
        }
        s = String(s.characters.dropLast())
        
        p.updateValue(s, forKey: "outbound")
        
        
        self.mainView.isHidden = true
        
        SVProgressHUD.show()
        
        let url = "\(Constant.domain)travelport/checkout?appKey=\(Constant.key)"
        
        NetworkManager.sharedInstance.requestPOSTURL(url, params: p, success: { (json) in
            
            if json["status"].stringValue == "success"{
                
                var dataObject = json["data"]
                var inboundObject = dataObject["inbound"]
                var outboundObject = dataObject["outbound"]
                
                var segments = inboundObject["segment"]
                
                self.base_rate.text = dataObject["airPricingSolution"]["BasePrice"].stringValue
                self.total_amount.text = dataObject["airPricingSolution"]["TotalPrice"].stringValue
                self.taxes.text = dataObject["airPricingSolution"]["Taxes"].stringValue

                
                if segments.count != 0 {
                
                    var tp_details : Tp_details_checkout = Tp_details_checkout()
                    for i in 0..<segments.count{
                    
                        var segmentIndex = segments[i]
                        tp_details  = Tp_details_checkout()
                        
                        
                        tp_details.company_name  = segmentIndex["detail"]["carrier"]["shortname"].stringValue
                        
                        let s = segmentIndex["FlightDetails"]["DepartureTime"].stringValue
                        
                        
                        self.dateFormatter.dateFormat = "mm : HH"
                        
                        let d = self.dateFormatter.date(from: s)

                        
                        tp_details.time_from = segmentIndex["FlightDetails"]["DepartureTime"].stringValue
                        tp_details.time_to = segmentIndex["FlightDetails"]["ArrivalTime"].stringValue
                        
                        tp_details.location_from = segmentIndex["FlightDetails"]["Origin"].stringValue
                        tp_details.location_to = segmentIndex["FlightDetails"]["Destination"].stringValue
                        tp_details.flight_number = segmentIndex["detail"]["equipment"]["code"].stringValue
                        tp_details.flight_class = segmentIndex["detail"]["bookingInfo"]["CabinClass"].stringValue
                        tp_details.total_duration = "\(segmentIndex["detail"]["totalDuration"]["day"].stringValue)D \(segmentIndex["detail"]["totalDuration"]["hour"].stringValue)H \(segmentIndex["detail"]["totalDuration"]["minute"].stringValue)M \(segmentIndex["detail"]["totalDuration"]["second"].stringValue)S"
                    
                        self.inbound_details.append(tp_details)
                    }
                
                }
                 segments = outboundObject["segment"]
                
                    var tp_details : Tp_details_checkout = Tp_details_checkout()
                    for i in 0..<segments.count{
                        
                        var segmentIndex = segments[i]
                        tp_details  = Tp_details_checkout()
                        
                        let imgURL = URL(string:segmentIndex["detail"]["carrier"]["image_path"].stringValue)
                        
                        self.company_name.text = segmentIndex["detail"]["carrier"]["shortname"].stringValue
                        
                        self.company_img.sd_setShowActivityIndicatorView(true)
                        self.company_img.sd_setIndicatorStyle(.gray)
                        
                        self.company_img.sd_setImage(with: imgURL)
                        
                        let s = segmentIndex["FlightDetails"]["DepartureTime"].stringValue

                        let dhh = self.dateFormatter.date(from: s)
  
                        
                        tp_details.company_name  = segmentIndex["detail"]["carrier"]["shortname"].stringValue
                        tp_details.time_from = segmentIndex["FlightDetails"]["DepartureTime"].stringValue
                        tp_details.time_to = segmentIndex["FlightDetails"]["ArrivalTime"].stringValue
                        tp_details.location_from = segmentIndex["FlightDetails"]["Origin"].stringValue
                        tp_details.location_to = segmentIndex["FlightDetails"]["Destination"].stringValue
                        tp_details.flight_number = segmentIndex["detail"]["equipment"]["code"].stringValue
                        tp_details.flight_class = segmentIndex["detail"]["bookingInfo"]["CabinClass"].stringValue
                        tp_details.total_duration = "\(segmentIndex["detail"]["totalDuration"]["day"].stringValue)D \(segmentIndex["detail"]["totalDuration"]["hour"].stringValue)H \(segmentIndex["detail"]["totalDuration"]["minute"].stringValue)M \(segmentIndex["detail"]["totalDuration"]["second"].stringValue)S"
                        
                        self.outbound_details.append(tp_details)
                    }
                
                self.departure_table.mainArray = self.outbound_details
                self.return_table.mainArray = self.inbound_details
                self.departure_view_height.constant = CGFloat(self.outbound_details.count * 130)
             

                
                
            }else if json["status"].stringValue == "fail"{
                
                Toast(text : "\(json["message"].stringValue)").show()
                _ = self.navigationController?.popViewController(animated: true)
                
            }
            SVProgressHUD.dismiss()
            self.mainView.isHidden = false

        }) { (error) in
            
            Toast(text : "\(error).stringValue)").show()
            _ = self.navigationController?.popViewController(animated: true)
            SVProgressHUD.dismiss()

        }
        
        
        UIView.animate(withDuration: Double(0.5), animations: {
            self.details_view_height.constant = 0
            self.view.layoutIfNeeded()
        })

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func details_click(_ sender: UIButton) {
        
        
     
        
        if self.details_view_height.constant == 0{
        
            UIView.animate(withDuration: Double(0.5), animations: {
                self.details_view_height.constant =  CGFloat(self.outbound_details.count * 135) +  CGFloat(self.inbound_details.count * 138)
                self.view.layoutIfNeeded()
            })

            
        }else{
            UIView.animate(withDuration: Double(0.5), animations: {
                self.details_view_height.constant = 0
                self.view.layoutIfNeeded()
            })
        
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pas_arr_book.removeAll()
    }

    @IBAction func NextStep(_ sender: Any) {
        
        getAllCells()
        if pas_arr_book.count != 0 {
            
               self.performSegue(withIdentifier: "show_credit_card", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "show_credit_card"{
            
            let searching = segue.destination as! CreditCard
            searching.pas_arr_book = pas_arr_book
        }
    }
    func getAllCells()  {
        
        self.view.endEditing(true)
        for section in 0..<pass_table.numberOfSections {
            
            for row in 0..<pass_table.numberOfRows(inSection: section) {
                
                let indexPath = IndexPath(row: row, section: section)
                let cell = pass_table.cellForRow(at: indexPath) as! PassengerCell

                if cell.nationality.text == "" || cell.email.text == "" || cell.phone.text == "" || cell.last_name.text == "" || cell.first_name.text == ""{
                    
                    Toast(text: "Please Specify \((cell.title.text)!) Attributes").show()
                    pas_arr_book.removeAll()
                }else{
                
                    let p : PasssengerModel = PasssengerModel()
            
                    
                    p.p_first = cell.first_name.text!
                    p.p_last = cell.last_name.text!
                    p.p_phone = cell.phone.text!
                    p.p_nationality = cell.nationality.text!
                    p.p_email = cell.email.text!
                    p.p_mtitle = cell.mr.text!
                    
                    if (cell.title.text?.lowercased().contains("adult"))! {
                    
                        p.p_code = "ADT"
                    
                    }else if (cell.title.text?.lowercased().contains("child"))! {
                        
                        p.p_code = "CNN"
                        
                    }else if (cell.title.text?.lowercased().contains("infant"))! {
                        
                        p.p_code = "INF"
                        
                    }
                    
                    pas_arr_book.append(p)
                
                }
                
            }
        }
    }


}
