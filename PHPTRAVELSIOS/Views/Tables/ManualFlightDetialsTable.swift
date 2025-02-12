





//
//  ManualFlightDetialsTable.swift
//  PHPTRAVELSIOS
//
//  Created by Qasim Hussain on 6/23/18.
//  Copyright © 2018 Qasim Hussain. All rights reserved.
//

import UIKit

class ManualFlightDetialsTable:  UITableView,UITableViewDataSource,UITableViewDelegate  {
    
    var mainArray:[OneWayModel] = []{
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
        
       

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.mainArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 158
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "ManualFlightDetialsCell", for: indexPath) as! ManualFlightDetialsCell
            let flight_object = self.mainArray[indexPath.row]
           cell.from_locations.text = flight_object.name
           cell.to_locations.text = flight_object.to_name
           cell.departure_date.text = flight_object.date
           cell.arrival_date.text = flight_object.to_date
           cell.arrival_time.text = flight_object.time
           cell.departure_time.text = flight_object.to_time
        
           return cell
        
    }
    
    
}

