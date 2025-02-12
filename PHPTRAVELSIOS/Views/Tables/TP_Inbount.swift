//
//  TP_Inbount.swift
//  memuDemo
//
//  Created by Qasim Hussain on 05/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class TP_Inbount: UITableView ,UITableViewDataSource,UITableViewDelegate,CheckUnCheckDelegate {
    
    
    var selected_array:[TravelPortDetails] = []
    
    
    var mainArray:[TravelPortDetails] = []{
        didSet{
            
            self.selected_array.removeAll()
            for i in 1..<mainArray.count{
                
                if mainArray[i].check_header_segment != "header"
                {
                    self.selected_array.append(mainArray[i])
                    
                }else{
                    break
                    
                }
            }
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
        
        if td.check_header_segment == "header"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "tp_header", for: indexPath) as! TravelPortDetialsCell
            
            
            return cell
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TravelPortDetialsCell", for: indexPath) as! TravelPortDetialsCell
            
            
            cell.delegate = self
            cell.indexPath = indexPath
            
            if td.check_inner_segment == "show_button"{
                
                cell.checkUncheck.isHidden = false
                
                if td.check_CheckUnChecked{
                    
                    cell.checkUncheck.setImage(#imageLiteral(resourceName: "marked"), for: .normal)
                    
                }else{
                    cell.checkUncheck.setImage(#imageLiteral(resourceName: "empty_circle"), for: .normal)
                    
                }
                
                
            }else{
                
                cell.checkUncheck.isHidden = true
                
                
            }
            cell.date_from.text = td.date_from
            cell.date_to.text = td.date_to
            cell.time_from.text = td.time_from
            cell.time_to.text = td.time_to
            cell.location_from.text = td.location_from
            cell.location_to.text = td.location_to
            
            
            return cell
            
        }
        
        
    }
    func CheckUnCheckClick(at index: IndexPath) {
        
        self.selected_array.removeAll()
        for i in 0..<mainArray.count{
            
            if(i == index.row)
            {
                mainArray[i].check_CheckUnChecked = true
                
            }else{
                
                mainArray[i].check_CheckUnChecked = false
            }
            
        }
        for i in index.row..<mainArray.count{
            
            if mainArray[i].check_header_segment != "header"{
                
                self.selected_array.append(mainArray[i])
            }else{
                
                break
            }
            
        }
        reloadData()
        
        
        
        
    }
    
}

