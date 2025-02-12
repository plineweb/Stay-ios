//
//  CarDetailsReq.swift
//  memuDemo
//
//  Created by Qasim Hussain on 11/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import SVProgressHUD

class CarDetailsReq: UIViewController {
    
    var car_info : CarInfo? = nil
    
    
    
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
        
        let car = segue.destination as! CarsDetails
        car.car_info = self.car_info
        car.car_details = self
        
    }
    
}

