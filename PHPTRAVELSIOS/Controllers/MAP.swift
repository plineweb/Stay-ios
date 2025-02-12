//
//  MAP.swift
//  memuDemo
//
//  Created by Qasim Hussain on 20/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import MapKit

class MAP: UIViewController {
  
    
    
    @IBOutlet weak var map: MKMapView!

    
    var overView : Overview? = nil {
        didSet{

            
            let location = CLLocationCoordinate2DMake(Double((overView?.latitude)!)!,Double((overView?.longitude)!)!)
            
            let span = MKCoordinateSpanMake(0.05,0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            map.setRegion(region, animated: true)
            
            let dropPin = MKPointAnnotation()
            dropPin.coordinate = location
            dropPin.title = "Location"
            map.addAnnotation(dropPin)
            
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
