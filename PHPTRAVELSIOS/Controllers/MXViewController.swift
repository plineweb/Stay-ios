import UIKit
import MXSegmentedPager
import SVProgressHUD
import Toaster


class MXViewController: MXSegmentedPagerController, SBSliderDelegate{

    
    var hotel_info : HotelInfo? = nil
    
    var mxTextContext : MXTextViewController? = nil
    
    var mRoomContext : HotelRoomController? = nil
    
    var mReviewContext : ReviewController? = nil
  
    var hotel_details : HotelDetailsViewController? = nil

    var reviewArray = [Review]()
    
 

    @IBOutlet var headerView: SBSliderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedPager.backgroundColor = .blue
        self.navigationController?.navigationBar.tintColor = UIColor.white

        self.hotel_details?.container_view.isHidden = true
        
        // Segmented Control customization
        segmentedPager.segmentedControl.selectionIndicatorLocation = .down
        segmentedPager.segmentedControl.backgroundColor = CommonMethods.hexStringToUIColor(hex:"#283349")
        segmentedPager.segmentedControl.titleTextAttributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15.0), NSAttributedStringKey.foregroundColor : UIColor.white]
        segmentedPager.segmentedControl.selectedTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.gray]
        segmentedPager.segmentedControl.selectionStyle = .fullWidthStripe
        segmentedPager.segmentedControl.selectionIndicatorColor = CommonMethods.hexStringToUIColor(hex:"#2E3192")
        
            headerView = Bundle.main.loadNibNamed("SBSliderView", owner: self, options: nil)?.first as! SBSliderView?
        
        headerView.delegate = self
    
        segmentedPager.parallaxHeader.view = headerView
        segmentedPager.parallaxHeader.mode = .fill
        segmentedPager.parallaxHeader.height = 250
        segmentedPager.parallaxHeader.minimumHeight = 0
        
        
        
        
        HotelDetailsRequest().getCarHotelDetails(hotel_info: self.hotel_info!) { (imageSlides,Amenities_arr,overview,payments,rooms,reviews,checkError,error) in
            
            SVProgressHUD.dismiss()
            if checkError{
                
                Toast.init(text: "error.msg").show()
                _ = self.navigationController?.popViewController(animated: true)
            }else{
                self.headerView.createSlider(withImages: imageSlides, withAutoScroll:true, in: self.view)
                self.reviewArray = reviews
                self.mxTextContext?.amenities_arry = Amenities_arr
                self.mxTextContext?.overView = overview
                self.mxTextContext?.payments_arry = payments
                self.mRoomContext?.hotel_info = self.hotel_info
                self.mRoomContext?.room_arry = rooms
                
                            
            }
            self.hotel_details?.container_view.isHidden = false
            
            UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
                self.hotel_details?.back_ground.alpha = 0 // Here you will get the animation you want
            }, completion: { _ in
                self.hotel_details?.back_ground.isHidden = true
            })

        
    }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "mx_page_0"{
            
           mxTextContext = segue.destination as? MXTextViewController
            
        } else if segue.identifier == "mx_page_1"{
        
           self.mRoomContext = segue.destination as? HotelRoomController
        }
        else if segue.identifier == "mx_page_2"{
            
            self.mReviewContext = segue.destination as? ReviewController
            print("Page 2",self.reviewArray.count)
            //self.mReviewContext?.review_arry = self.reviewArray
        }

    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, didSelectViewWith index: Int) {
        
        if index == 2
        {
            self.mReviewContext?.review_arry = self.reviewArray
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
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        
        return ["OVERVIEW", "ROOMS", "REVIEWS"][index]
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, didScrollWith parallaxHeader: MXParallaxHeader) {
    }
}
