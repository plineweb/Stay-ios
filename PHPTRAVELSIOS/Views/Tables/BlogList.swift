//
//  BlogList.swift
//  memuDemo
//
//  Created by Qasim Hussain on 07/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit

class BlogList: UITableView,UITableViewDelegate,UITableViewDataSource {
    
    var controller : BlogController? = nil
    
    
    var blogObject:[Overview] = []{
        didSet{
            reloadData()
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate=self
        self.dataSource=self
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        controller?.overview = self.blogObject[indexPath.row]
        controller?.performSegue(withIdentifier: "show_blog_details", sender: self)
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return blogObject.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "blogcell", for: indexPath) as! BlogCell
        
        
        let blog : Overview = self.blogObject[indexPath.row]
        
        cell.blog_title.text = blog.desc
        
        cell.blog_desc.text = blog.id
        
        
        
        let imgURL = URL(string:blog.policy)
        
        cell.blog_img.sd_setShowActivityIndicatorView(true)
        cell.blog_img.sd_setIndicatorStyle(.gray)
        cell.blog_img.sd_setImage(with: imgURL)
        
        
        return cell
        
    }
    
    
    
    
}

