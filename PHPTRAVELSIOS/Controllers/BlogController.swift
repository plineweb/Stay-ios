//
//  BlogController.swift
//  memuDemo
//
//  Created by Qasim Hussain on 07/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import SVProgressHUD
import Toaster

class BlogController: UIViewController {

    @IBOutlet weak var menu: UIBarButtonItem!
    
    @IBOutlet weak var blog_table: BlogList!
    
    var overview : Overview? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        
        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationController?.navigationBar.barTintColor =  CommonMethods.hexStringToUIColor(hex: "#2E3192")
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        var result_arr = [Overview]()
        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Loading")
        NetworkManager.sharedInstance.requestGETURL("\(Constant.domain)blog/list?appKey=\(Constant.key)", success: { (json) in
            
            var mainArray = json["response"]
            
            var post_arr = mainArray["posts"]
            
            for i in 0..<post_arr.count{
                
                let post_obj = post_arr[i]
                
                let over = Overview(id: post_obj["description"].stringValue, desc: post_obj["title"].stringValue, policy: post_obj["thumbnail"].stringValue, latitude: "", longitude: "")
                
                result_arr.append(over)
            }
            self.blog_table.blogObject = result_arr
            self.blog_table.controller = self

            SVProgressHUD.dismiss()
            
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            
            let searching = segue.destination as! BlogDetails
            searching.overveiw = self.overview
            
     
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
