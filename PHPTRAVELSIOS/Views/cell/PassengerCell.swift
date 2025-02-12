//
//  PassengerCell.swift
//  memuDemo
//
//  Created by Qasim Hussain on 06/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class PassengerCell: UITableViewCell, UITextFieldDelegate{
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var nationality: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var last_name: UITextField!
    @IBOutlet weak var first_name: UITextField!
    @IBOutlet weak var mr: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nationality.delegate = self
        email.delegate = self
        phone.delegate = self
        last_name.delegate = self
        first_name.delegate = self
        mr.delegate = self
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

