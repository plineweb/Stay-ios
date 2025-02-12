//
//  ProfileController.swift
//  memuDemo
//
//  Created by Qasim Hussain on 11/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster
import SVProgressHUD

class ProfileController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var postal_code: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var address2: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var confirm_password: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone_number: UITextField!
    @IBOutlet weak var last_name: UITextField!
    @IBOutlet weak var first_name: UITextField!
    var id : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white

        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationController?.navigationBar.barTintColor =  CommonMethods.hexStringToUIColor(hex: "#2E3192")
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        if CommonMethods.preferences.object(forKey: "login") == nil {
            //  Doesn't exist
        } else {
            
            let decoded : Array  = CommonMethods.preferences.array(forKey: "login")!
            self.id = decoded[2] as! String
            
            print("my id \(self.id)")
            
        }
        
        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Loading")
        
        NetworkManager.sharedInstance.requestGETURL("\(Constant.domain)login/profile?appKey=\(Constant.key)&id=\(id)", success: { (json) in
            
            var myResponse = json["response"]
            
            self.country.text = myResponse["ai_country"].stringValue
            self.state.text =  myResponse["ai_state"].stringValue
            self.postal_code.text = myResponse["ai_postal_code"].stringValue
            self.city.text = myResponse["ai_city"].stringValue
            self.address2.text = myResponse["ai_address_2"].stringValue
            self.address.text = myResponse["ai_address_1"].stringValue
            self.email.text = myResponse["accounts_email"].stringValue
            self.phone_number.text = myResponse["ai_mobile"].stringValue
            self.last_name.text = myResponse["ai_last_name"].stringValue
            self.first_name.text = myResponse["ai_first_name"].stringValue
            
            
        }) { (error) in
            SVProgressHUD.dismiss()

            Toast.init(text: error.localizedDescription).show()
        }

        state.delegate = self
        postal_code.delegate = self
        city.delegate = self
        address2.delegate = self
        address.delegate = self
        confirm_password.delegate = self
        password.delegate = self
        email.delegate = self
        phone_number.delegate = self
        last_name.delegate = self
        first_name.delegate = self

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.CheckInClick(_:)))
        
        self.country.isUserInteractionEnabled = true
        
        self.country.addGestureRecognizer(tap)
        
    }

    
    @objc func CheckInClick(_ sender: UITapGestureRecognizer) {
        
        let picker = MICountryPicker { (name, code) -> () in
            print(code)
        }
        picker.delegate = self
        picker.didSelectCountryClosure = { name, code in
            picker.navigationController?.popToRootViewController(animated: true)
        }
        navigationController?.pushViewController(picker, animated: true)
        
    }
    
    
 
    @IBAction func udate(_ sender: Any) {
        
        print("My Name = \(self.first_name.text!)")
        print("My Name = \(self.last_name.text!)")
        print("My Name = \(self.city.text!)")

        print("My Name = \(self.country.text!)")
        print("My Name = \(self.address.text!)")
        print("My Name = \(self.address2.text!)")
        print("My Name = \(self.phone_number.text!)")
        print("My Name = \(self.id)")


        let p : [String:String] =
            ["firstname":"\(self.first_name.text!)" ,
            "id":"\(self.id)",
            "last_name":"\(self.last_name.text!)",
            "city":"\(self.city.text!)",
            "country":"\(self.country.text!)",
            "address1":"\(self.address.text!)",
            "address2":"\(self.address2.text!)",
            "phone":"\(self.phone_number.text!)",
            "zip":"\(self.postal_code.text!)",
            "email":"\(self.email.text!)",
            "state":"\(self.state.text!)"
        ]
        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Loading")
        NetworkManager.sharedInstance.requestPOSTURL("\(Constant.domain)login/updateprofile?appKey=\(Constant.key)", params: p, success: { (json) in
            
            
            if json["response"].boolValue{
                
                Toast(text: "Update Successfully").show()
                self.performSegue(withIdentifier: "show_main_login", sender: self)
            }else{
                
                Toast(text: json["error"]["msg"].stringValue).show()
            }
            
            SVProgressHUD.dismiss()
      
            
        }) { (error) in
            SVProgressHUD.dismiss()

            Toast.init(text : error.localizedDescription).show()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ProfileController: MICountryPickerDelegate {
    func countryPicker(_ picker: MICountryPicker, didSelectCountryWithName name: String, code: String) {
        picker.navigationController?.popToRootViewController(animated: true)
       country.text = "\(name)"
    }
}

