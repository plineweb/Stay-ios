//
//  ReviewController.swift
//  memuDemo
//
//  Created by Qasim Hussain on 19/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class ReviewController: UIViewController {
    
    @IBOutlet weak var Reviews: Review_table!
    var review_arry:[Review] = []{
        didSet{
            
            Reviews.review_Object = review_arry
            print("MY Array : ",review_arry.count)

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
