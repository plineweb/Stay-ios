//
//  NameImageTable.swift
//  memuDemo
//
//  Created by Qasim Hussain on 21/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import SDWebImage

class NameImageTable: UITableView,UITableViewDataSource,UITableViewDelegate  {
    
    
    var mainArray:[NameImage] = []{
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
        
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.mainArray.count;
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameimage_cell", for: indexPath) as! MenuCell
        
        
        let imageName : NameImage = self.mainArray[indexPath.row]
        
        cell.imgIcon.image =  #imageLiteral(resourceName: "checked")
        
        cell.lblMenuname.text = imageName.name
        
        return cell
        
    }
    
    
    
}


