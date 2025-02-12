//
//  CarsDetails.swift
//  memuDemo
//
//  Created by Qasim Hussain on 25/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import MXSegmentedPager
import SVProgressHUD
import Toaster

class CarsDetails: MXSegmentedPagerController, SBSliderDelegate{
    
    
    var car_info : CarInfo? = nil
    var car_overView : Car_Overveiw? = nil
    var car_booking : Car_Booking? = nil
    var car_Map : MAP? = nil
    var overview : Overview? = nil
    var car_details : CarDetailsReq? = nil


    @IBOutlet var headerView: SBSliderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedPager.backgroundColor = .blue
        self.navigationController?.navigationBar.tintColor = UIColor.white

        segmentedPager.segmentedControl.selectionIndicatorLocation = .down
        segmentedPager.segmentedControl.backgroundColor = CommonMethods.hexStringToUIColor(hex:"#283349")
        segmentedPager.segmentedControl.titleTextAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 14.0), NSForegroundColorAttributeName : UIColor.white]
        segmentedPager.segmentedControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName : UIColor.gray]
        segmentedPager.segmentedControl.selectionStyle = .fullWidthStripe
        segmentedPager.segmentedControl.selectionIndicatorColor = CommonMethods.hexStringToUIColor(hex:"#2E3192")
        
        headerView = Bundle.main.loadNibNamed("SBSliderView", owner: self, options: nil)?.first as! SBSliderView?
        
        headerView.delegate = self
        
        segmentedPager.parallaxHeader.view = headerView
        segmentedPager.parallaxHeader.mode = .fill
        segmentedPager.parallaxHeader.height = 250
        segmentedPager.parallaxHeader.minimumHeight = 0
        
        
        SVProgressHUD.show()
        
        CarRequest().getCarDetails(car_info: self.car_info!) { (imageSlides,overview,payments,pickup_array,dropoff_array,carinfo,error) in
     
            if error != ""{
                
                Toast.init(text: error).show()
                _ = self.navigationController?.popViewController(animated: true)

                
            }else{
                self.headerView.createSlider(withImages: imageSlides, withAutoScroll:true, in: self.view)
                
                self.car_overView?.overView = overview
                self.car_overView?.payments_arry = payments
                self.car_booking?.pickup_array = pickup_array
                self.car_booking?.drop_off_array = dropoff_array
                self.car_booking?.car_info = carinfo
                self.overview = overview
                
                self.car_details?.container_view.isHidden = false
                
                UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                    self.car_details?.back_ground.alpha = 0 // Here you will get the animation you want
                }, completion: { _ in
                    self.car_details?.back_ground.isHidden = true
                })
            }
       

        }
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "mx_page_0"{
            
            self.car_overView = segue.destination as? Car_Overveiw
            
        } else if segue.identifier == "mx_page_1"{
            
            self.car_booking = segue.destination as? Car_Booking
            
        }
        else if segue.identifier == "mx_page_2"{
            self.car_Map = segue.destination as? MAP

        }
        
        
    }
    
    
    
    
    
    
    func sbslider(_ sbslider: SBSliderView, didTapOn targetImage: UIImage, andParentView targetView: UIImageView) {
        let photoViewerManager = SBPhotoManager()
        photoViewerManager.initializePhotoViewer(fromViewControlller: self, forTargetImageView: targetView, withPosition: sbslider.frame)
    }
    
    
    @IBAction func tappedOnSampleImage(_ sender: Any) {
        let gesture: UIGestureRecognizer? = (sender as? UIGestureRecognizer)
        let targetView: UIImageView? = (gesture?.view as? UIImageView)
        let photoViewerManager = SBPhotoManager()
        photoViewerManager.initializePhotoViewer(fromViewControlller: self, forTargetImageView: targetView!, withPosition: (targetView?.frame)!)
        
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, didSelectViewWith index: Int) {
        
        if index == 2
        {
            self.car_Map?.overView = self.overview
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        
        return ["OVERVIEW", "BOOKING", "MAP"][index]
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, didScrollWith parallaxHeader: MXParallaxHeader) {
    }

}
