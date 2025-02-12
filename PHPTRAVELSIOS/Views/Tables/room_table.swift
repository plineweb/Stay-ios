//
//  room_table.swift
//  memuDemo
//
//  Created by Qasim Hussain on 17/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import APJTextPickerView
import Toaster



class room_table: UITableView,UITableViewDataSource,UITableViewDelegate,APJTextPickerViewDelegate, APJTextPickerViewDataSource,BookDelegate{
    
    
    var hazm : String = ""
    
    var controller : HotelRoomController? = nil
    
    var quantity : [String] = ["1 Rooms","2 Rooms","3 Rooms","4 Rooms","5 Rooms","6 Rooms","7 Rooms","8 Rooms","9 Rooms","10 Rooms","11 Rooms","12 Rooms","13 Rooms","14 Rooms","15 Rooms","16 Rooms", "17 Rooms","18 Rooms","19 Rooms","20 Rooms" ,"21 Rooms" ,"22 Rooms" ,"23 Rooms" ,"24 Rooms" ,"25 Rooms" ,"26 Rooms" ,"27 Rooms" ,"28 Rooms" ,"29 Rooms" ,"30 Rooms" ,"31 Rooms" ,"32 Rooms" ,"33 Rooms" ,"34 Rooms" ,"35 Rooms" ,"36 Rooms" ,"37 Rooms" ,"38 Rooms" ,"39 Rooms" ,"40 Rooms" ,"41 Rooms" ,"42 Rooms" ,"43 Rooms" ,"44 Rooms" ,"45 Rooms" ,"46 Rooms" ,"47 Rooms" ]
    
    var roomObject:[Room_Model] = []{
        didSet{
            reloadData()
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate=self
        self.dataSource=self
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return roomObject.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! RoomCell
        
        
        let rm : Room_Model = self.roomObject[indexPath.row]
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        
        cell.room_name.text = rm.room_name
        cell.room_price.text = rm.room_price
        cell.room_quantity.text = "1 Rooms"
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        let imgURL = URL(string:rm.room_img_url)
        
        cell.room_img.sd_setShowActivityIndicatorView(true)
        cell.room_img.sd_setIndicatorStyle(.gray)
        cell.room_img.sd_setImage(with: imgURL)
        
        cell.room_quantity.tag = Int(rm.room_quantity)!
        cell.room_quantity.type = .strings
        cell.room_quantity.pickerDelegate = self
        cell.room_quantity.dataSource = self
        
        
        return cell
        
    }
    func buttonBook(at index: IndexPath) {
        
        
        if CommonMethods.preferences.object(forKey: "login") == nil ||  CommonMethods.checkCoupon{
            
            self.controller?.roomObject = roomObject[index.row]
            self.controller?.performSegue(withIdentifier: "show_invoice", sender: self)
            
        } else {
            
            let user : [String] =  CommonMethods.preferences.array(forKey: "login") as! [String]
            
            var pro = HotelInfo(id : "",child : "",adult : "" ,checkin : "", checkout : "")
            
            
            HotelBookingRequest().HotelBooking(guest: "", profile: pro, coupon_id: "0", id : user[2],hotel_info : (self.controller?.hotel_info)!,roomOb : roomObject[index.row]) { (result,error) in
                
                if error != ""{
                    
                    Toast.init(text: error).show()
                    
                }else{
                    if result[0] == "yes"{
                        
                        Toast.init(text: result[1]).show()
                        
                    }else{
                        
                        self.controller?.url = result[1]
                        self.controller?.performSegue(withIdentifier: "show_webview", sender: self)
                    }
                    
                }
                
            }
            
            
        }
        
        
        
        
        
        
    }
    func roomQunitity(sender : MyTapGesture){
        
        
        quantity.removeAll()
        for i in 0..<Int(sender.title)!{
            
            quantity.append("\(i)")
        }
        
    }
    
    class MyTapGesture: UITapGestureRecognizer {
        var title = String()
    }
    
    
    
    
    func textPickerView(_ textPickerView: APJTextPickerView, didSelectString row: Int) {
        
        print("This number is selected \(row)")
        roomObject[row].room_quantity = "\(row+1)"
    }
    
    func textPickerView(_ textPickerView: APJTextPickerView, titleForRow row: Int) -> String? {
        
        
        return quantity[row]
        
    }
    func numberOfRows(in pickerView: APJTextPickerView) -> Int {
        
        
        return pickerView.tag
        
    }
    
}

