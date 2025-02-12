//
//  AboutUs.swift
//  memuDemo
//
//  Created by Qasim Hussain on 11/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster
import SVProgressHUD

class AboutUs: UIViewController {

    @IBOutlet weak var name_txt: UILabel!
    @IBOutlet weak var menu: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationController?.navigationBar.barTintColor =  CommonMethods.hexStringToUIColor(hex: "#2E3192")
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        // Do any additional setup after loading the view.
        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Loading")
        NetworkManager.sharedInstance.requestGETURL("\(Constant.domain)modulesinfo/aboutus?appKey=\(Constant.key)", success: { (json) in
            
              self.name_txt.text =   json["response"].stringValue
            
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
