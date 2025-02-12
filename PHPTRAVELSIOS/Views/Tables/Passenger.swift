//
//  Passenger.swift
//  memuDemo
//
//  Created by Qasim Hussain on 06/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class Passenger: UITableView,UITableViewDataSource,UITableViewDelegate {
    
    
    var pass_arr:[PasssengerModel] = []{
        didSet{
            reloadData()
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.separatorStyle = UITableViewCellSeparatorStyle.none
        self.dataSource = self
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pass_arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pss = self.pass_arr[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "passenger", for: indexPath) as! PassengerCell
        
        cell.title.text = pss.p_title
        
        
        return cell
        
    }
    
    
    
}

