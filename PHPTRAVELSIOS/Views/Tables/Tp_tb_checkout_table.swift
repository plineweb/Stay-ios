//
//  Tp_tb_checkout_table.swift
//  memuDemo
//
//  Created by Qasim Hussain on 07/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class Tp_tb_checkout_table: UITableView,UITableViewDataSource,UITableViewDelegate {
    
    
    
    var mainArray:[Tp_details_checkout] = []{
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
        return mainArray.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let td = mainArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tp_checkout_details", for: indexPath) as! Tp_checkout_details
        
        cell.time.text = td.total_duration
        cell.class_type.text = td.flight_class
        cell.flight_number.text = td.flight_number
        cell.location_to.text = td.location_to
        cell.location_from.text = td.location_from
        cell.company_name.text = td.company_name
        cell.time_to.text = td.time_to
        cell.time_from.text = td.time_from
        
        
        return cell
        
    }
}




