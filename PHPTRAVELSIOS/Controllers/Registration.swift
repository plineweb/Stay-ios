//
//  Registration.swift
//  memuDemo
//
//  Created by Qasim Hussain on 06/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster
import SVProgressHUD

class Registration: UIViewController, UITextFieldDelegate{

    
    @IBOutlet weak var goto_login: UILabel!
    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var first_name: UITextField!
    @IBOutlet weak var last_name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phone_number: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationController?.navigationBar.barTintColor =  CommonMethods.hexStringToUIColor(hex: "#2E3192")
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.CheckInClick(_:)))
        
        self.goto_login.isUserInteractionEnabled = true
        
        self.goto_login.addGestureRecognizer(tap)


        first_name.delegate = self
        last_name.delegate = self
        email.delegate = self
        password.delegate = self
        phone_number.delegate = self
        
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
    
    func CheckInClick(_ sender: UITapGestureRecognizer) {
        
        self.performSegue(withIdentifier: "show_login", sender: self)
    }

    @IBAction func Sign_Up(_ sender: Any) {
        
        if email.text == "" || first_name.text == "" || last_name.text == "" || phone_number.text == "" || password.text == ""
        {
        
            Toast(text: "Please Fill The Above Requirments").show()

        
        }else {
        let p : [String:String] = ["email":"\(email.text!)" ,
            "first_name":"\(first_name.text!)",
            "last_name":"\(last_name.text!)",
            "phone":"\(phone_number.text!)",
            "password":"\(password.text!)"]
        
            SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
            SVProgressHUD.setForegroundColor(.white)
            SVProgressHUD.show(withStatus: "Loading")
            NetworkManager.sharedInstance.requestPOSTURL("\(Constant.domain)login/signup?appKey=\(Constant.key)", params: p, success: { (json) in
                
                
                if json["response"].boolValue{
                    
                    self.performSegue(withIdentifier: "show_login", sender: self)
                    Toast.init(text : "Sign Up Succefully").show()

                    
                }else{
                    
                    Toast(text: json["error"]["msg"].stringValue).show()
                    
                }
                
                
                SVProgressHUD.dismiss()
                
                
            }) { (error) in
                
                SVProgressHUD.dismiss()
                Toast.init(text : error.localizedDescription).show()
            }
            
        }
    }
}
