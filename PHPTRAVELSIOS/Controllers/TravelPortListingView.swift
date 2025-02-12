//
//  TravelPortListingView.swift
//  memuDemo
//
//  Created by Qasim Hussain on 26/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import SwiftyJSON
import Toaster
import SVProgressHUD
class TravelPortListingView: UIViewController {

    @IBOutlet weak var travel_port_table: TravelPortTable!
    var flights_arr : [TravelPortModel] = []
    var details_arr : [TravelPortDetails] = []
    
    var outbound_rec : [TravelPortDetails] = []
    var inbound_rec : [TravelPortDetails] = []
    
    


    var checkType = "oneway"
    var tourInfo : TourInfo? = TourInfo(id : "",location: "", date: "",adults: "",type: "",child : "",infants : "")
    var hotelInfo : HotelInfo? = HotelInfo(id : "",child : "",adult : "" ,checkin : "", checkout : "")
    let mainstoryboard:UIStoryboard = UIStoryboard(name: "CarHotelTour", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white


        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Loading")
        
        var url = ""
        
        if hotelInfo?.child != "0" || hotelInfo?.adult != "0"{
            
              url = "\(Constant.domain)travelport/search?appKey=\(Constant.key)&origin=\((hotelInfo?.child)!)&destination=\((hotelInfo?.adult)!)&departure=\((hotelInfo?.checkin)!)&arrival=\((hotelInfo?.checkout)!)&triptype=\((hotelInfo?.id)!)&cabinclass=\((tourInfo?.date)!)&passenger[adult]=\((tourInfo?.adults)!)&passenger[children]=\((tourInfo?.child)!)&passenger[infant]=\((tourInfo?.infants)!)&passenger[total]=\(Int((tourInfo?.adults)!)!+Int((tourInfo?.child)!)!+Int((tourInfo?.infants)!)!)"
            
        }else{
            
            url = "\(Constant.domain)travelport/flights?appKey=\(Constant.key)"
        }
        NetworkManager.sharedInstance.requestGETURL(url, success: { (json) in
            
            if json["status"].stringValue == "success"{
                
                
                let mainObject = json["data"]
                
                for numberOfObject in mainObject {
                    
                    let flightObject = mainObject[numberOfObject.0]
                    
                    for flights in flightObject{
                        
                        let finalObject = flightObject[flights.0]
                        
                        let indexObject1 = finalObject["outbound"]
                        
                        let price = finalObject["price"]
                        
                        let travelPortModel : TravelPortModel? = TravelPortModel()
                        
                        travelPortModel?.aero_plane_number = indexObject1["aircraft"]["equipment"]["code"].stringValue
                        travelPortModel?.take_off_destination = indexObject1["origin"]["airport"]["code"].stringValue
                        travelPortModel?.arrivalDestination = indexObject1["destination"]["airport"]["code"].stringValue
                        
                        
                        
                        travelPortModel?.total_time = "\(indexObject1["totalDuration"]["day"].stringValue)D \(indexObject1["totalDuration"]["day"].stringValue)H \(indexObject1["totalDuration"]["minute"].stringValue)M"
                        
                        
                        travelPortModel?.toatl_stop = "\(indexObject1["flightItinerary"]["totalStops"].stringValue) Stops"
                        travelPortModel?.takeOff_time = "\(indexObject1["origin"]["departure"]["time"]["hour"].stringValue) : \(indexObject1["origin"]["departure"]["time"]["minute"].stringValue)"
                        travelPortModel?.arrival_time = "\(indexObject1["destination"]["arrival"]["time"]["hour"].stringValue) : \(indexObject1["destination"]["arrival"]["time"]["minute"].stringValue)"
                        travelPortModel?.name_aero = indexObject1["aircraft"]["carrier"]["shortname"].stringValue
                        travelPortModel?.img_aero = indexObject1["aircraft"]["carrier"]["image_path"].stringValue
                        
                        travelPortModel?.price = price["totalprice_value"].stringValue
                        travelPortModel?.currCode = price["totalprice_unit"].stringValue
                        
                        
                        let segments = indexObject1["flightItinerary"]["segments"]
                        
                        var details = TravelPortDetails()
                        
                        self.travel_port_table.controller = self
                        
                        for i in 0..<segments.count {
                            
                            let segmentsOb = segments[i]
                            
                            details = TravelPortDetails()
                            details.check_header_segment = "header"
                            
                            travelPortModel?.detials.append(details)
                            
                            for j in 0..<segmentsOb.count{
                                
                                let innerSegments = segmentsOb[j]
                                details = TravelPortDetails()
                                
                                if i == 0{
                                    
                                    details.check_CheckUnChecked = true
                                    
                                }else{
                                    details.check_CheckUnChecked = false
                                    
                                    
                                }
                                
                                if j == 0
                                {
                                    details.check_inner_segment = "show_button"
                                    
                                    
                                }else{
                                    details.check_inner_segment = "hide_button"
                                    
                                }
                                
                                details.date_from = "\(innerSegments["departureTime"]["date"]["day"].stringValue)/\(innerSegments["departureTime"]["date"]["month"].stringValue)/\(innerSegments["departureTime"]["date"]["year"].stringValue)"
                                details.date_to = "\(innerSegments["arrivalTime"]["date"]["day"].stringValue)/\(innerSegments["arrivalTime"]["date"]["month"].stringValue)/\(innerSegments["arrivalTime"]["date"]["year"].stringValue)"
                                details.location_from = "\(innerSegments["origin"]["code"].stringValue)"
                                
                                details.time_from = "\(innerSegments["departureTime"]["time"]["hour"].stringValue) : \(innerSegments["departureTime"]["time"]["minute"].stringValue)"
                                details.time_to = "\(innerSegments["arrivalTime"]["time"]["hour"].stringValue) : \(innerSegments["arrivalTime"]["time"]["minute"].stringValue)"
                                
                                
                                details.location_to = "\(innerSegments["destination"]["code"].stringValue)"
                                details.key = "\(innerSegments["key"].stringValue)"
                                details.flight_type = "\(innerSegments["bookingInformation"]["CabinClass"].stringValue)"
                                
                                travelPortModel?.detials.append(details)
                                
                            }
                            
                        }
                        
                        
                        
                        if finalObject["inbound"].exists(){
                            
                            self.checkType = "round"
                            
                            let indexObject2 = finalObject["inbound"]
                            
                            travelPortModel?.b_inbound = true
                            
                            travelPortModel?.b_aero_code = indexObject2["aircraft"]["equipment"]["code"].stringValue
                            travelPortModel?.b_takeOff_time = "\(indexObject2["origin"]["departure"]["time"]["hour"].stringValue) : \(indexObject2["origin"]["departure"]["time"]["minute"].stringValue)"
                            
                            travelPortModel?.b_takeOffDestination = indexObject2["origin"]["airport"]["code"].stringValue
                            travelPortModel?.b_total_stop = "\(indexObject2["flightItinerary"]["totalStops"].stringValue) Stops"
                            travelPortModel?.b_toatl_time = "\(indexObject2["totalDuration"]["day"].stringValue)D \(indexObject2["totalDuration"]["day"].stringValue)H \(indexObject2["totalDuration"]["minute"].stringValue)M"
                            travelPortModel?.b_arrival_time = "\(indexObject2["destination"]["arrival"]["time"]["hour"].stringValue) : \(indexObject2["destination"]["arrival"]["time"]["minute"].stringValue)"
                            travelPortModel?.b_takeOff_time = "\(indexObject2["origin"]["departure"]["time"]["hour"].stringValue) : \(indexObject2["origin"]["departure"]["time"]["minute"].stringValue)"
                            travelPortModel?.b_arrivalDestination = indexObject2["destination"]["airport"]["code"].stringValue
                            
                            
                            
                            let segments = indexObject2["flightItinerary"]["segments"]
                            
                            var details = TravelPortDetails()
                            
                            for i in 0..<segments.count {
                                
                                let segmentsOb = segments[i]
                                
                                details = TravelPortDetails()
                                details.check_header_segment = "header"
                                
                                travelPortModel?.detials_inbounds.append(details)
                                
                                for j in 0..<segmentsOb.count{
                                    
                                    let innerSegments = segmentsOb[j]
                                    details = TravelPortDetails()
                                    
                                    if i == 0{
                                        
                                        details.check_CheckUnChecked = true
                                        
                                    }else{
                                        details.check_CheckUnChecked = false
                                        
                                        
                                    }
                                    
                                    if j == 0
                                    {
                                        details.check_inner_segment = "show_button"
                                        
                                        
                                    }else{
                                        details.check_inner_segment = "hide_button"
                                        
                                    }
                                    
                                    details.date_from = "\(innerSegments["departureTime"]["date"]["day"].stringValue)/\(innerSegments["departureTime"]["date"]["month"].stringValue)/\(innerSegments["departureTime"]["date"]["year"].stringValue)"
                                    details.date_to = "\(innerSegments["arrivalTime"]["date"]["day"].stringValue)/\(innerSegments["arrivalTime"]["date"]["month"].stringValue)/\(innerSegments["arrivalTime"]["date"]["year"].stringValue)"
                                    details.location_from = "\(innerSegments["origin"]["code"].stringValue)"
                                    details.location_to = "\(innerSegments["destination"]["code"].stringValue)"
                                    details.flight_type = "\(innerSegments["bookingInformation"]["CabinClass"].stringValue)"
                                    details.time_from = "\(innerSegments["departureTime"]["time"]["hour"].stringValue) : \(innerSegments["departureTime"]["time"]["minute"].stringValue)"
                                    details.time_to = "\(innerSegments["arrivalTime"]["time"]["hour"].stringValue) : \(innerSegments["arrivalTime"]["time"]["minute"].stringValue)"
                                    
                                    details.key = "\(innerSegments["key"].stringValue)"
                                    
                                    
                                    travelPortModel?.detials_inbounds.append(details)
                                    
                                }
                                
                            }
                        }
                        self.flights_arr.append(travelPortModel!)
                        
                    }
                    self.travel_port_table.controller = self
                   self.travel_port_table.checkType = self.checkType
                 self.travel_port_table.mainArray = self.flights_arr
                    
                }
            
            
            }else if json["status"].stringValue == "fail"{
            
                Toast(text : "\(json["message"].stringValue)").show()
                _ = self.navigationController?.popViewController(animated: true)

            }
        }) { (error) in
            
            Toast(text : "\(error).stringValue)").show()
            _ = self.navigationController?.popViewController(animated: true)

        }
        
        
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "tp_checkout"{
        
            let searching = segue.destination as! T_p_checkout
            searching.inbound_rec = inbound_rec
            searching.outbound_rec = outbound_rec
            searching.tourInfo = self.tourInfo
        }
        
        
    }


}
