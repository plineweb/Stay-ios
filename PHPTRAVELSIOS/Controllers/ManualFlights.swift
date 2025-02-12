//
//  ManualFlights.swift
//  PHPTRAVELSIOS
//
//  Created by Qasim Hussain on 4/22/18.
//  Copyright © 2018 Qasim Hussain. All rights reserved.
//

import UIKit
import Toaster
import Alamofire
import SVProgressHUD

class ManualFlights: UIViewController {

    var flight_info : HotelInfo? = nil
    var cabin_info : TourInfo? = nil
    var main_array = [TravelPortDetails]()
    
    @IBOutlet weak var main_table: ManualFlightsTable!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        var type_check = ""
        if (flight_info?.id)! == "oneway"
        {
            type_check = "oneway"
        }else{
            type_check = "return"

        }

        let url = "\(Constant.domain)flights/search?appKey=\(Constant.key)&from=\((flight_info?.child)!)&to=\((flight_info?.adult)!)&departure_date=\((flight_info?.checkin)!)&arrival_date=\((flight_info?.checkout)!)&type=\(type_check)&cabinclass=\((cabin_info?.date)!)&adults=\((cabin_info?.adults)!)&childs=\((cabin_info?.child)!)&infants=\((cabin_info?.infants)!)&total=\(Int((cabin_info?.adults)!)!+Int((cabin_info?.child)!)!+Int((cabin_info?.infants)!)!)"
        
        
        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Loading")
        NetworkManager.sharedInstance.requestGETURL(url, success: { (json) in
            
            if !json["error"]["status"].bool! {
                
                
                var mainArray  = [ManualFlightModel]()
                let mainObject = json["response"].arrayValue
                
                for numberOfObject in mainObject {
                    
                    var oneway = numberOfObject["oneway"]
                    var return_ = numberOfObject["return"]

                    var flight_object = ManualFlightModel()
                    flight_object.des = oneway["desc_flight"].stringValue
                    flight_object.total_time = oneway["total_hours"].stringValue
                    flight_object.id = oneway["id"].stringValue
                    flight_object.price = oneway["price"].stringValue
                    flight_object.currSymbol = oneway["currency"].stringValue
                    flight_object.currCode = oneway["symbol"].stringValue
                    flight_object.aero_name = oneway["name"].stringValue
                    for innerObject in oneway["mainArray"].arrayValue{
                        var innerModel = OneWayModel()
                        innerModel.code = innerObject["from_code"].stringValue
                        innerModel.name = innerObject["from_label"].stringValue
                        innerModel.date = innerObject["from_date"].stringValue
                        innerModel.flight_no = innerObject["flight_no"].stringValue
                        innerModel.time = innerObject["from_time"].stringValue
                        innerModel.img = innerObject["aero_img"].stringValue
                        innerModel.to_code = innerObject["to_code"].stringValue
                        innerModel.to_date = innerObject["to_date"].stringValue
                        innerModel.to_time = innerObject["to_time"].stringValue
                        innerModel.to_name = innerObject["to_label"].stringValue
                        flight_object.models_array.append(innerModel)
                    }
                    if (self.flight_info?.id)! != "oneway"{
                        for innerObject in return_["mainArray"].arrayValue{
                            var innerModel = OneWayModel()
                            innerModel.code = innerObject["from_code"].stringValue
                            innerModel.name = innerObject["from_label"].stringValue
                            innerModel.date = innerObject["from_date"].stringValue
                            innerModel.flight_no = innerObject["flight_no"].stringValue
                            innerModel.time = innerObject["from_time"].stringValue
                            innerModel.img = innerObject["aero_img"].stringValue
                            innerModel.to_code = innerObject["to_code"].stringValue
                            innerModel.to_date = innerObject["to_date"].stringValue
                            innerModel.to_time = innerObject["to_time"].stringValue
                            innerModel.to_name = innerObject["to_label"].stringValue
                            flight_object.return_array.append(innerModel)
                        }
                    }
                 
                    mainArray.append(flight_object)
                    self.main_table.checktype = (self.flight_info?.id)!
                    self.main_table.controller = self
                    self.main_table.mainArray = mainArray
                    
                }
            }else {
                
                Toast(text : "\(json["error"]["msg"].stringValue)").show()
                _ = self.navigationController?.popViewController(animated: true)
                
            }
            SVProgressHUD.dismiss()

        }) { (error) in
            
            Toast(text : "\(error.localizedDescription)").show()
            _ = self.navigationController?.popViewController(animated: true)
            SVProgressHUD.dismiss()

            
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
