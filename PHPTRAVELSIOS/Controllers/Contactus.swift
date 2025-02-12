//
//  Contactus.swift
//  memuDemo
//
//  Created by Qasim Hussain on 11/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster
import SVProgressHUD

class Contactus: UIViewController {

    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    var email_id : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationController?.navigationBar.barTintColor =  CommonMethods.hexStringToUIColor(hex: "#2E3192")
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Loading")
        
        NetworkManager.sharedInstance.requestGETURL("\(Constant.domain)contact/info?appKey=\(Constant.key)", success: { (json) in
            
            var mainArray = json["response"]
            
            self.address.text = mainArray["contact_address"].stringValue
            self.email_id = mainArray["contact_email"].stringValue
            
            SVProgressHUD.dismiss()
            
        }) { (error) in
            SVProgressHUD.dismiss()
            
            Toast.init(text: error.localizedDescription).show()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    @IBAction func send(_ sender: UIButton) {
        
        if self.email.text == "" || self.message.text == "" || self.subject.text == "" || self.name.text == ""{
            
            Toast(text: "Please Fill The Above Requirments").show()

        
        }else{
        
            let p : [String:String] = ["email":"\(email.text!)" ,
                "name":"\(name.text!)",
                "subject":"\(subject.text!)",
                "message":"\(message.text!)",
                "sendto":"\(email_id)"]
            
            
            SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
            SVProgressHUD.setForegroundColor(.white)
            SVProgressHUD.show(withStatus: "Loading")
            
            NetworkManager.sharedInstance.requestPOSTURL("\(Constant.domain)contact/send/info?appKey=\(Constant.key)", params: p, success: { (json) in
                
                var result = ""
                
                if json["response"]["sent"].boolValue{
                    
                    result = "Request Send"
                    
                    
                }else{
                    
                    result = "Something Error"
                    
                }
                self.view.endEditing(true)
                Toast.init(text : result).show()
                
                SVProgressHUD.dismiss()
                
                
            }) { (error) in
                
                SVProgressHUD.dismiss()
                Toast.init(text : error.localizedDescription).show()
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
