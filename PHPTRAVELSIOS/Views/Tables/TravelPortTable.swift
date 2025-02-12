//
//  TravelPortTable.swift
//  memuDemo
//
//  Created by Qasim Hussain on 26/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class TravelPortTable: UITableView,UITableViewDataSource,UITableViewDelegate,RecivedSelectedArray {
    
    
    
    var checkType = ""
    var firstLoad = true
    var controller : TravelPortListingView? = nil
    var flight_array:[TravelPortModel] = []
    var mainArray:[TravelPortModel] = []{
        didSet{
            flight_array =  mainArray.map{$0}
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
        
        var j = 0
        for i in 0..<flight_array.count{
            
            if flight_array[i].checkInsert{
                let insertionIndexPath = IndexPath(row: i, section: 0)
                deleteCell(indexPath: insertionIndexPath)
                j = i
                break
            }
        }
        if j != indexPath.row+1{
            if j > indexPath.row || j == 0{
                insert(indexPath : indexPath)
                
            }else {
                let insertionIndexPath = IndexPath(row: indexPath.row-1, section: 0)
                
                insert(indexPath : insertionIndexPath)
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if  flight_array[indexPath.row].checkInsert {
            
            if flight_array[indexPath.row].b_inbound{
                return CGFloat((flight_array[indexPath.row].detials.count * 50)+70) + CGFloat((flight_array[indexPath.row].detials_inbounds.count * 50)+80)
            }
            else{
                return CGFloat((flight_array[indexPath.row].detials.count * 50)+70)
            }
            
        } else {
            
            if checkType == "oneway"{
                return 63
            }else{
                return 125
            }
        }
    }
    
    func deleteCell(indexPath: IndexPath) {
        
        flight_array.remove(at: indexPath.row)
        self.deleteRows(at: [indexPath], with: .automatic)
        
    }
    
    func insert(indexPath : IndexPath) {
        let newM  = TravelPortModel()
        newM.checkInsert = true
        newM.detials = flight_array[indexPath.row].detials
        newM.detials_inbounds = flight_array[indexPath.row].detials_inbounds
        newM.b_inbound = self.flight_array[indexPath.row].b_inbound
        
        if indexPath.row + 1 == flight_array.count + 1{
            
            
            flight_array.append(newM)
            
        }
        else{
            
            flight_array.insert(newM, at: indexPath.row+1)
            
        }
        
        let insertionIndexPath = IndexPath(row: indexPath.row+1 , section: 0)
        
        self.insertRows(at: [insertionIndexPath], with: .automatic)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.flight_array.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tm : TravelPortModel = self.flight_array[indexPath.row]
        
        if !tm.checkInsert{
            
            if checkType == "oneway"{
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "oneway", for: indexPath) as! TravelPortCell
                
                cell.price.text = "\(tm.currCode) \(tm.price)"
                cell.name_aero.text = tm.name_aero
                cell.takeOff_time.text = tm.takeOff_time
                cell.arrival_time.text = tm.arrival_time
                cell.total_time.text = tm.total_time
                cell.arrivalDestination.text = tm.arrivalDestination
                cell.toatl_stop.text = tm.toatl_stop
                cell.take_off_destination.text = tm.take_off_destination
                cell.aero_plane_number.text = "Flights : \(tm.aero_plane_number)"
                
                let imgURL = URL(string:tm.img_aero)
                
                cell.img_aero.sd_setShowActivityIndicatorView(true)
                cell.img_aero.sd_setIndicatorStyle(.gray)
                
                cell.img_aero.sd_setImage(with: imgURL)
                
                
                return cell
                
            }else{
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "TravelPortCell", for: indexPath) as! TravelPortCell
                
                cell.price.text = "\(tm.currCode) \(tm.price)"
                cell.name_aero.text = tm.name_aero
                cell.takeOff_time.text = tm.takeOff_time
                cell.arrival_time.text = tm.arrival_time
                cell.total_time.text = tm.total_time
                cell.arrivalDestination.text = tm.arrivalDestination
                cell.toatl_stop.text = tm.toatl_stop
                cell.take_off_destination.text = tm.take_off_destination
                cell.aero_plane_number.text = "Flights : \(tm.aero_plane_number)"
                
                cell.b_aero_code.text = "Flights : \(tm.b_aero_code)"
                cell.b_arrivalDestination.text = tm.b_arrivalDestination
                cell.b_total_stop.text = tm.b_total_stop
                cell.b_takeOffDestination.text = tm.b_takeOffDestination
                cell.b_total_time.text = tm.b_toatl_time
                cell.b_arrival_time.text = tm.b_arrival_time
                cell.b_takeOff_time.text = tm.b_takeOff_time
                
                let imgURL = URL(string:tm.img_aero)
                
                cell.img_aero.sd_setShowActivityIndicatorView(true)
                cell.img_aero.sd_setIndicatorStyle(.gray)
                
                
                
                cell.img_aero.sd_setImage(with: imgURL)
                
                return cell
                
            }
            
            
            
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "hiderow", for: indexPath) as! HideRowCell
            
            
            cell.tp_details_tb.mainArray = tm.detials
            cell.details_delegate = self
            cell.inbounds_height.constant = CGFloat((flight_array[indexPath.row].detials.count * 53))
            cell.recivieData = cell.tp_details_tb.selected_array
            
            if flight_array[indexPath.row].b_inbound{
                cell.out_bounds_tb.mainArray = tm.detials_inbounds
                cell.out_recivieData = cell.out_bounds_tb.selected_array
                
            }
            
            
            return cell
            
        }
        
    }
    
    func UpdateRecData(at recivieData: [TravelPortDetails], inboundData: [TravelPortDetails]) {
        
        controller?.inbound_rec = inboundData
        controller?.outbound_rec = recivieData
        
        if CommonMethods.preferences.object(forKey: "login") == nil{
            
            let searchController  = self.controller?.mainstoryboard.instantiateViewController(withIdentifier: "Login_Book") as! Login_Book
            
            searchController.inbound_rec = inboundData
            searchController.model = "travelport"
            searchController.outbound_rec = recivieData
            searchController.tourInfo = self.controller?.tourInfo
            self.controller?.navigationController?.pushViewController(searchController, animated: true)
            
        } else {
            
            self.controller?.performSegue(withIdentifier: "tp_checkout", sender: self)
            
            
        }
        
        
        
        
    }
    
    
}

