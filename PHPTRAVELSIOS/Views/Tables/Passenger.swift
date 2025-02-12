//
//  Passenger.swift
//  memuDemo
//
//  Created by Qasim Hussain on 06/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import APJTextPickerView

class Passenger: UITableView,UITableViewDataSource,UITableViewDelegate,APJTextPickerViewDelegate,APJTextPickerViewDataSource,CountryDelegate {

    
    
    var mr_array = ["Mr","Miss","Mrs"]
    var controller : T_p_checkout? = nil
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
        
        cell.delegate = self
        cell.indexPath = indexPath
        cell.title.text = pss.p_title
        
        cell.mr_view.text = "Mr"
        
        cell.mr_view.type = .strings
        cell.mr_view.pickerDelegate = self
        cell.mr_view.dataSource = self
        return cell
        
    }
    func c_click(at index: IndexPath) {
        
        let cell = self.cellForRow(at: index) as! PassengerCell

        
        let picker = MICountryPicker { (name, code) -> () in
            print(code)
        }
        picker.delegate = self
        picker.didSelectCountryClosure = { name, code in
        cell.country_btn.setTitle(name, for: .normal)
        }
        self.controller?.navigationController?.pushViewController(picker, animated: true)
    }
    
    func textPickerView(_ textPickerView: APJTextPickerView, didSelectString row: Int) {
        
        
    }
    
    func textPickerView(_ textPickerView: APJTextPickerView, titleForRow row: Int) -> String? {
        
        
        return mr_array[row]
        
    }
    func numberOfRows(in pickerView: APJTextPickerView) -> Int {
        
        
        return mr_array.count
        
    }
    
}

extension Passenger: MICountryPickerDelegate {
    func countryPicker(_ picker: MICountryPicker, didSelectCountryWithName name: String, code: String) {
        _ = picker.navigationController?.popViewController(animated: true)


    }
}

