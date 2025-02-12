//
//  InclusionsExclusions.swift
//  memuDemo
//
//  Created by Qasim Hussain on 21/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class InclusionsExclusions: UIViewController {

    @IBOutlet weak var incluExcluTable: NameImageTable!
    
    var inclusions:[NameImage] = []{
        didSet{
            incluExcluTable.mainArray = inclusions
        }
    }
    
    var exclusions:[NameImage] = []{
        didSet{
            incluExcluTable.mainArray = exclusions

        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
