//
//  ManualFlightsTable.swift
//  PHPTRAVELSIOS
//
//  Created by Qasim Hussain on 4/23/18.
//  Copyright © 2018 Qasim Hussain. All rights reserved.
//

import UIKit

class ManualFlightsTable:  UITableView,UITableViewDataSource,UITableViewDelegate  {
    
    var checktype = ""
    var controller : ManualFlights? = nil
    var mainArray:[ManualFlightModel] = []{
        didSet{
            reloadData()
        }
    }
    
    
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate=self
        self.dataSource=self
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let flight_object = self.mainArray[indexPath.row]
        var sendArray : [OneWayModel] = []
        sendArray = flight_object.models_array + flight_object.return_array
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "TravelPort", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ManualFlightDetialsController") as! ManualFlightDetialsController
        newViewcontroller.mainArray = sendArray
        newViewcontroller.id = flight_object.id
        newViewcontroller.flight_info = controller?.flight_info
        newViewcontroller.cabin_info = controller?.cabin_info
        newViewcontroller.url = flight_object.models_array[0].img
        self.controller?.navigationController?.pushViewController(newViewcontroller, animated: true)

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.mainArray.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if checktype == "oneway"
        {
            return 80

        }else{
            return 120

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if checktype == "oneway"
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "oneway", for: indexPath) as! TravelPortCell
            var flight_object = self.mainArray[indexPath.row]
            
            cell.arrival_time.text = flight_object.models_array.last?.to_time
            cell.takeOff_time.text = flight_object.models_array[0].time
            cell.aero_plane_number.text = flight_object.models_array[0].flight_no
            cell.total_time.text = "Total Time : \(flight_object.total_time)"
            cell.toatl_stop.text =  "Stop \(flight_object.models_array.count - 1)"
            cell.take_off_destination.text = flight_object.models_array[0].code
            cell.arrivalDestination.text = flight_object.models_array.last?.to_code
            cell.price.text = "\(flight_object.currCode)\(flight_object.price)\(flight_object.currSymbol)"
            cell.name_aero.text = flight_object.aero_name
            let imgURL = URL(string:flight_object.models_array[0].img)
            cell.img_aero.sd_setShowActivityIndicatorView(true)
            cell.img_aero.sd_setIndicatorStyle(.gray)
            cell.img_aero.sd_setImage(with: imgURL)
            
            return cell

            
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TravelPortCell", for: indexPath) as! TravelPortCell
            var flight_object = self.mainArray[indexPath.row]
            
            cell.arrival_time.text = flight_object.models_array.last?.to_time
            cell.takeOff_time.text = flight_object.models_array[0].time
            cell.aero_plane_number.text = flight_object.models_array[0].flight_no
            cell.total_time.text = "Total Time : \(flight_object.total_time)"
            cell.toatl_stop.text =  "Stop \(flight_object.models_array.count - 1)"
            cell.take_off_destination.text = flight_object.models_array[0].code
            cell.arrivalDestination.text = flight_object.models_array.last?.to_code
            cell.price.text = "\(flight_object.currCode)\(flight_object.price)\(flight_object.currSymbol)"
            cell.name_aero.text = flight_object.aero_name
            
            let imgURL = URL(string:flight_object.models_array[0].img)
            cell.img_aero.sd_setShowActivityIndicatorView(true)
            cell.img_aero.sd_setIndicatorStyle(.gray)
            cell.img_aero.sd_setImage(with: imgURL)
            
            
            cell.b_total_stop.text =  "Stop \(flight_object.return_array.count - 1)"
            cell.b_takeOffDestination.text = flight_object.return_array[0].code
            cell.b_arrivalDestination.text = flight_object.return_array.last?.to_code
            cell.b_arrival_time.text = flight_object.return_array.last?.to_time
            cell.b_takeOff_time.text = flight_object.return_array[0].time

            
            
            return cell

            
        }
        
        

        
        
        
    }
    
    
}

