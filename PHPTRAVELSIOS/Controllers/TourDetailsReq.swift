//
//  TourDetailsReq.swift
//  memuDemo
//
//  Created by Qasim Hussain on 11/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import SVProgressHUD

class TourDetailsReq: UIViewController {
    
    var details_tours : TourDetails? = nil
    var checkModel =  ""
    var tuor_info : TourInfo? = nil
    
    
    
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
        
            let tour = segue.destination as! TourDetails
            tour.tuor_info = self.tuor_info
            tour.tour_details = self
        
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
