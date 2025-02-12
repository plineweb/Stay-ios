//
//  Car_Overveiw.swift
//  memuDemo
//
//  Created by Qasim Hussain on 27/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class Car_Overveiw: UIViewController {

    @IBOutlet weak var policy: UILabel!

    @IBOutlet weak var payments_options: AmenitiesCollection!
    @IBOutlet weak var descText: UILabel!

    
    
    @IBOutlet weak var dropoff_locations: UILabel!
    var overView : Overview? = nil {
        didSet{
            
            self.policy.text = overView?.policy
            self.descText.text = overView?.desc
            
        }
    }
    
    var payments_arry:[NameImage] = []{
        didSet{
            payments_options.mainArray = payments_arry
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
