//
//  TourDetails.swift
//  memuDemo
//
//  Created by Qasim Hussain on 21/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import MXSegmentedPager
import SVProgressHUD
import Toaster


class TourDetails: MXSegmentedPagerController, SBSliderDelegate{
    
    
    var tuor_info : TourInfo? = nil
    
    var Inclusiotn : InclusionsExclusions? = nil
    
    
    @IBOutlet var popup: Pop_up_table!
    
    var exclusion : InclusionsExclusions? = nil
    
    var tour_overview : TourOverview? = nil

    
    var review : ReviewController? = nil
    var tour_details : TourDetailsReq? = nil


    
    var exclusionArray = [NameImage]()
    
    var reviewArray = [Review]()



    
    
    @IBOutlet var headerView: SBSliderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedPager.backgroundColor = .blue
        self.navigationController?.navigationBar.tintColor = UIColor.white

        
        // Segmented Control customization
        segmentedPager.segmentedControl.selectionIndicatorLocation = .down
        segmentedPager.segmentedControl.backgroundColor = CommonMethods.hexStringToUIColor(hex:"#283349")
        segmentedPager.segmentedControl.titleTextAttributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14.0), NSAttributedStringKey.foregroundColor : UIColor.white]
        segmentedPager.segmentedControl.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.gray]
        segmentedPager.segmentedControl.selectionStyle = .fullWidthStripe
        segmentedPager.segmentedControl.selectionIndicatorColor = CommonMethods.hexStringToUIColor(hex:"#2E3192")
        headerView = Bundle.main.loadNibNamed("SBSliderView", owner: self, options: nil)?.first as! SBSliderView?
        
        headerView.delegate = self
        
        segmentedPager.parallaxHeader.view = headerView
        segmentedPager.parallaxHeader.mode = .fill
        segmentedPager.parallaxHeader.height = 250
        segmentedPager.parallaxHeader.minimumHeight = 0
        
        

        TourDetailsRequest().getTourDetails(tourInfo: self.tuor_info!) { (imageSlides,InclusionsArray,ExclusionsArray,overview,paymentsArray,reviewArray,error) in
            

            if error != ""{
                
                Toast.init(text: error).show()
                _ = self.navigationController?.popViewController(animated: true)

                
            }else{
                self.headerView.createSlider(withImages: imageSlides, withAutoScroll:true, in: self.view)
                
                self.Inclusiotn?.inclusions = InclusionsArray
                
                self.exclusionArray = ExclusionsArray
                
                self.reviewArray = reviewArray
                
                self.tour_overview?.overView = overview
                
                self.tour_overview?.payments_arry = paymentsArray
                self.tour_overview?.tour_info = self.tuor_info
                
            }
            
            self.tour_details?.container_view.isHidden = false
            
            UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                self.tour_details?.back_ground.alpha = 0 // Here you will get the animation you want
            }, completion: { _ in
                self.tour_details?.back_ground.isHidden = true
            })

            
            
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "mx_page_0"{
            
            self.tour_overview = segue.destination as? TourOverview

            
        } else if segue.identifier == "mx_page_1"{
            
            self.Inclusiotn = segue.destination as? InclusionsExclusions

            
        }
        else if segue.identifier == "mx_page_2"{
            
            self.exclusion = segue.destination as? InclusionsExclusions
            
        }else if segue.identifier == "mx_page_3"{
            
            self.review = segue.destination as? ReviewController
            
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
               self.exclusion?.exclusions = self.exclusionArray

        }
       else if index == 3
        {
            self.review?.review_arry = self.reviewArray
            
        }
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        
        return ["OVERVIEW", "INCLUSIONS", "EXCLUSIONS","REVIEWS"][index]
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, didScrollWith parallaxHeader: MXParallaxHeader) {
    }
}

