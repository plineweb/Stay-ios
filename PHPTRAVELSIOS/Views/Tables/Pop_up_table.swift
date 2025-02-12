//
//  Pop_up_table.swift
//  memuDemo
//
//  Created by Qasim Hussain on 22/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class Pop_up_table: UITableView,UITableViewDataSource,UITableViewDelegate {
    
    
    var controller : TourDetails? = nil
    
    
    var mainArray:[String] = []{
        didSet{
            reloadData()
        }
        
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate=self
        self.dataSource=self
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        animateOut ()
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.mainArray.count;
    }
    
    func animateOut () {
        // poup_background.isHidden = true
        
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.alpha = 0
            
            
        }) { (success:Bool) in
            self.removeFromSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=UITableViewCell()
        
        cell.textLabel?.text=mainArray[indexPath.row]
        
        return cell
        
    }
    
    
    
}

