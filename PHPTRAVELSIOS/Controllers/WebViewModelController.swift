//
//  WebViewModelController.swift
//  memuDemo
//
//  Created by Qasim Hussain on 12/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster

class WebViewModelController: UIViewController ,UIWebViewDelegate{
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var WebView: UIWebView!
    @IBOutlet weak var menu: UIBarButtonItem!
    
    var url : String = ""
    
    var type : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationController?.navigationBar.barTintColor =  CommonMethods.hexStringToUIColor(hex: "#2E3192")
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        if self.type == "cartrawler"{
            
            
            GetIframByUrl().getCartrawler() { (url,error) in
                
                if error != ""{
                    
                    Toast.init(text : error).show()
                    
                }else{
                    self.url = url
                    let url_string = URL(string:self.url)
                    
                    self.WebView.loadRequest(URLRequest(url: url_string!))
                }
             
                
            }
        }else if self.type == "travelpayouts"{
            
            GetIframByUrl().getUrlByName(name : "travelpayouts") { (url,error) in
                
                if error != ""{
                    Toast.init(text: error).show()

                }else{
                    
                    self.url = url
                    let url_string = URL(string:self.url)
                    
                    self.WebView.loadRequest(URLRequest(url: url_string!))
                    
                }
                
            }
        }else if self.type == "travelstart"{
            
            GetIframByUrl().getUrlByName(name : "travelstart") { (url,error) in
                
                if error != ""{
            
                    Toast.init(text: error).show()

                }else{
                    self.url = url
                    let url_string = URL(string:self.url)
                    
                    self.WebView.loadRequest(URLRequest(url: url_string!))
                    
                    
                }

            }
        }else if self.type == "hotelscombined"{
            
            GetIframByUrl().getHotelCombined() { (url,error) in
                
                if error != ""{
                    Toast.init(text : error).show()

                }else{
                    self.url = url
                    let url_string = URL(string:self.url)
                    
                    self.WebView.loadRequest(URLRequest(url: url_string!))
                }
              
            }
        }else if self.type == "wego"{
            
            GetIframByUrl().getUrlByName(name : "wego") { (url,error) in
                
                if error != ""{
                    Toast.init(text: error).show()

                }else{
                    self.url = url
                    let url_string = URL(string:self.url)
                    
                    self.WebView.loadRequest(URLRequest(url: url_string!))
                    
                }
            }
        }else{
            
            let url_string = URL(string:self.url)
            
            self.WebView.loadRequest(URLRequest(url: url_string!))
            
            
        }
        
        
        
        
        WebView.delegate = self
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(_ animated: Bool) {
        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        
        indicator.stopAnimating()
        
        
    }
    
    
}
