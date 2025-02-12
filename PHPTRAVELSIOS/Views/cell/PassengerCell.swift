//
//  PassengerCell.swift
//  memuDemo
//
//  Created by Qasim Hussain on 06/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import APJTextPickerView

protocol CountryDelegate{
    func c_click(at index:IndexPath)
}
class PassengerCell: UITableViewCell, UITextFieldDelegate{
    
    var indexPath:IndexPath!
    
    var delegate:CountryDelegate!
    @IBOutlet weak var country_btn: UIButton!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var nationality: UITextField!
    @IBOutlet weak var email: UITextField!
  
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var last_name: UITextField!
    @IBOutlet weak var first_name: UITextField!
    @IBOutlet weak var mr: UITextField!
    
    @IBOutlet weak var mr_view: APJTextPickerView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nationality.delegate = self
        email.delegate = self
        phone.delegate = self
        last_name.delegate = self
        first_name.delegate = self
        mr.delegate = self
        
        country_btn.contentHorizontalAlignment = .left
        country_btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
    }
    
    @IBAction func Click_Country(_ sender: UIButton) {
        
         self.delegate?.c_click(at: indexPath)
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

