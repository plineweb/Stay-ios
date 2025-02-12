//
//  CheckInvoice.swift
//  memuDemo
//
//  Created by Qasim Hussain on 06/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster
import SVProgressHUD

class CheckInvoice: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var invoice_code: UITextField!
    @IBOutlet weak var invoice_number: UITextField!
    @IBOutlet weak var menu: UIBarButtonItem!

    @IBOutlet weak var hide_label: UILabel!
    var url : String = ""
    let mainstoryboard:UIStoryboard = UIStoryboard(name: "CarHotelTour", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationController?.navigationBar.barTintColor =  CommonMethods.hexStringToUIColor(hex: "#2E3192")
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        invoice_code.delegate = self
        invoice_number.delegate = self 

        for i in 0..<CommonMethods.ModeluArray.count {
            
            if CommonMethods.ModeluArray[i].type == "0"
            {
                hide_label.isHidden = false
                
            }
            
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func check_invoice(_ sender: UIButton) {
        
        
        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Loading")
        NetworkManager.sharedInstance.requestGETURL("\(Constant.domain)invoice/info?appKey=\(Constant.key)&invoiceno=\(invoice_number.text!)&invoicecode=\(invoice_code.text!)", success: { (json) in
            
            var mainArray = json["response"]
            
            if mainArray["error"].stringValue == ""
            {
                let searchController  = self.mainstoryboard.instantiateViewController(withIdentifier: "webview") as! WebViewHomeController
                searchController.url = mainArray["url"].stringValue
                self.navigationController?.pushViewController(searchController, animated: true)
                
                
            }else{
                self.view.endEditing(true)
                Toast(text: mainArray["error"].stringValue).show()
            }
            SVProgressHUD.dismiss()
            
            
        }) { (error) in
            SVProgressHUD.dismiss()
            Toast.init(text: error.localizedDescription).show()
        }
     
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "show_webview"{
            
            let searching = segue.destination as! WebViewHomeController
            searching.url = self.url
        }
        
        
    }

}
