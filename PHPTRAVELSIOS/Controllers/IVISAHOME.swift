//
//  IVISAHOME.swift
//  PHPTRAVELS
//
//  Created by Qasim Hussain on 13/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster
import SVProgressHUD

class IVISAHOME: UIViewController {

    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var location_to: UIButton!
    @IBOutlet weak var location_from: UIButton!
    var checkLocation = ""
    var code = "pakistan"
    
    @IBOutlet weak var container_view: UIView!
    var code_to = "turkey"
    let mainstoryboard:UIStoryboard = UIStoryboard(name: "CarHotelTour", bundle: nil)
    let main:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let c_view : UIViewController = (self.mainstoryboard.instantiateViewController(withIdentifier: "main_container_view"))

        
        
        c_view.view.frame = container_view.bounds
        container_view.addSubview((c_view.view)!)
        addChildViewController(c_view)
        c_view.didMove(toParentViewController: self)
        
        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationController?.navigationBar.barTintColor =  CommonMethods.hexStringToUIColor(hex: "#2E3192")
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        navigationController?.navigationBar.barTintColor =  CommonMethods.hexStringToUIColor(hex: "#2E3192")
        
        
    }

    @IBAction func Location_to_click(_ sender: UIButton) {
        let picker = MICountryPicker { (name, code) -> () in
            print(code)
        }
        
        picker.delegate = self
        picker.didSelectCountryClosure = { name, code in
            picker.navigationController?.popToRootViewController(animated: true)
        }
        checkLocation = "to"
        navigationController?.pushViewController(picker, animated: true)
    }
  
    @IBAction func location_from_click(_ sender: UIButton) {
        
        let picker = MICountryPicker { (name, code) -> () in
            print(code)
        }
        picker.delegate = self
        picker.didSelectCountryClosure = { name, code in
            picker.navigationController?.popToRootViewController(animated: true)
        }
        checkLocation = "from"

        navigationController?.pushViewController(picker, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func search(_ sender: UIButton) {
        
        

        
        if self.code_to == "0" || self.code == "0"{
            
            Toast.init(text: "Please Select Nationality and Destination").show()
            
        }else{
            SVProgressHUD.setForegroundColor(.white)
            SVProgressHUD.show(withStatus: "Loading")
            SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
            GetIframByUrl().getIvisa(from: self.code, to: self.code_to) { (url, error) in
                
                SVProgressHUD.dismiss()
                if error == "success"{
                    
                    let searchController  = self.mainstoryboard.instantiateViewController(withIdentifier: "webview") as! WebViewHomeController
                    let urlf = url
                    let urlM = urlf.replacingOccurrences(of : "//", with: "/")
                    let final_url_ = urlM.replacingOccurrences(of: ":/", with: "://")
                    searchController.url = "\(final_url_)?appKey=\(Constant.key)"
                    self.navigationController?.pushViewController(searchController, animated: true)
                }else if error == "fail"{
                    let searchController  = self.mainstoryboard.instantiateViewController(withIdentifier: "webview") as! WebViewHomeController
                    searchController.url = url
                    self.navigationController?.pushViewController(searchController, animated: true)
                    
                }else{
                    Toast.init(text: error).show()

                    
                }
                
            }
            
        }
        
     
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

}
extension IVISAHOME: MICountryPickerDelegate {
    func countryPicker(_ picker: MICountryPicker, didSelectCountryWithName name: String, code: String) {
        picker.navigationController?.popToRootViewController(animated: true)
        picker.navigationController?.navigationBar.tintColor = UIColor.white

        if checkLocation == "to"{
         
            location_to.setTitle(name, for: .normal)
            self.code = name
            
        }else{
            location_from.setTitle(name, for: .normal)
            self.code_to = name
        }
    }
}
