//
//  OffersDetails.swift
//  memuDemo
//
//  Created by Qasim Hussain on 10/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster
import SVProgressHUD

class OffersDetails: UIViewController,SBSliderDelegate,UITextFieldDelegate{


    @IBOutlet weak var mScrollView: UIScrollView!
    @IBOutlet weak var send_name: UITextField!
   
    @IBOutlet weak var contact_details: UIView!
    @IBOutlet weak var send_message: UITextField!
    @IBOutlet weak var send_email: UITextField!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var name: UILabel!
    var overview : HotelListing? = nil
    var ov : Overview? = nil
    
    @IBOutlet weak var contact_border: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.white

        var overvi : Overview? = Overview(id: "", desc: "", policy: "", latitude: "", longitude: "")
        var imagesArray = [String]()
        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Loading")
        NetworkManager.sharedInstance.requestGETURL("\(Constant.domain)offers/offerdetails?appKey=\(Constant.key)&id=\((overview?.Hotel_Id)!)", success: { (json) in
            
            var mainArray = json["response"]
            var image_slider = mainArray["sliderImages"]
            
            
            overvi = Overview(id: mainArray["id"].stringValue, desc: mainArray["desc"].stringValue, policy: mainArray["title"].stringValue, latitude: mainArray["phone"].stringValue, longitude: "")
            
            for i in 0..<image_slider.count{
                
                imagesArray.append(image_slider[i]["thumbImage"].stringValue)
                
            }
            self.name.text = overvi?.policy
            self.desc.text = overvi?.desc
            
            let imgURL = URL(string:imagesArray[0])
            self.img.sd_setShowActivityIndicatorView(true)
            self.img.sd_setIndicatorStyle(.gray)
            self.img.sd_setImage(with: imgURL)
            self.ov = overvi
            
            
            
            SVProgressHUD.dismiss()

            
        }) { (error) in
            SVProgressHUD.dismiss()
            
            Toast.init(text: error.localizedDescription).show()
        }
        
        self.send_name.delegate = self
        self.send_email.delegate = self
        self.send_message.delegate = self
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        mScrollView.setContentOffset(CGPoint(x: 0, y: 500), animated: true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func send(_ sender: UIButton) {
        
        if send_email.text == ""{
        
            Toast(text: "Please Fill The Above Requirments").show()

            
        }else{
        
            let p : [String:String] = ["toemail":"\(send_email.text!)" ,
                "name":"\(send_message.text!)",
                "message":"\(send_name.text!)",
                "phone":"\((ov?.latitude)!)"]
            
            SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
            SVProgressHUD.setForegroundColor(.white)
            SVProgressHUD.show(withStatus: "Loading")
            NetworkManager.sharedInstance.requestPOSTURL("\(Constant.domain)offers/sendMessage?appKey=\(Constant.key)", params: p, success: { (json) in
                self.view.endEditing(true)
                if json["status"].boolValue{
                    Toast.init(text : json["error"].stringValue).show()

                }else{
                    Toast.init(text : json["response"].stringValue).show()

                }
                
                SVProgressHUD.dismiss()
                
                
            }) { (error) in
                
                SVProgressHUD.dismiss()
                Toast.init(text : error.localizedDescription).show()
            }
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

}
