//
//  BlogDetails.swift
//  memuDemo
//
//  Created by Qasim Hussain on 10/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class BlogDetails: UIViewController {

    var overveiw : Overview? = nil
    
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var desc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        self.desc.text = overveiw?.id
        
        let imgURL = URL(string:(overveiw?.policy)!)
        
        imageview.sd_setShowActivityIndicatorView(true)
        imageview.sd_setIndicatorStyle(.gray)
        imageview.sd_setImage(with: imgURL)
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
