//
//  Review_table.swift
//  memuDemo
//
//  Created by Qasim Hussain on 19/08/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit



class Review_table: UITableView,UITableViewDataSource,UITableViewDelegate {
    
    var review_Object:[Review] = []{
        didSet{
            reloadData()
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.estimatedRowHeight = 60
        self.rowHeight = UITableViewAutomaticDimension
        self.delegate = self
        self.separatorStyle = UITableViewCellSeparatorStyle.none
        self.dataSource = self
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return review_Object.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        
        let review = review_Object[indexPath.row]
        
        cell.Review_Name.text = review.name
        cell.Review_date.text = review.date
        cell.Review_rating.text = review.rating
        cell.Review_text.text = review.review_txt
        
        return cell
        
    }
    
    
}

