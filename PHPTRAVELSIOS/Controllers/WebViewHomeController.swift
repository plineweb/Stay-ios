//
//  MessageViewController.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit
import SVProgressHUD

class WebViewHomeController: UIViewController ,UIWebViewDelegate{

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var WebView: UIWebView!
    @IBOutlet weak var menu: UIBarButtonItem!
    
    var url : String = ""
    
    var type : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.white

        SVProgressHUD.dismiss()
        
           let url_string = URL(string:self.url)
                
             self.WebView.loadRequest(URLRequest(url: url_string!))

              WebView.delegate = self
        


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        
        indicator.stopAnimating()

        
    }


}
