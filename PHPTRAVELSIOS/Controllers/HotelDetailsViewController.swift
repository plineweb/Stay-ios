//
//  HotelDetailsViewController.swift
//  memuDemo
//
//  Created by Qasim Hussain on 10/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import SVProgressHUD

class HotelDetailsViewController: UIViewController {

    var hotel_info : HotelInfo? = nil
    var details_hotels : MXViewController? = nil



    @IBOutlet weak var back_ground: UIImageView!
    @IBOutlet weak var container_view: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.white

       
        SVProgressHUD.show()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            let hotel_details = segue.destination as! MXViewController
            hotel_details.hotel_info = self.hotel_info
            hotel_details.hotel_details = self
        
    }

}
