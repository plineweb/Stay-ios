//
//  CabinContorller.swift
//  memuDemo
//
//  Created by Qasim Hussain on 22/09/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit


protocol  cabinDataTransfer {
    func cabinDataTransferM(at tourInfo : TourInfo)
}
class CabinContorller: UIViewController {

    var delegate : cabinDataTransfer?
    @IBOutlet weak var first_class: UIButton!
    @IBOutlet weak var business_img: UIButton!
    @IBOutlet weak var eco_img: UIButton!
    @IBOutlet weak var first_view: UIView!
    @IBOutlet weak var business_view: UIView!
    @IBOutlet weak var economy_view: UIView!
    
    @IBOutlet weak var adults: UILabel!
    @IBOutlet weak var childs: UILabel!
    @IBOutlet weak var infants: UILabel!
    
    var cabinString : String = "Economy"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.view.backgroundColor = CommonMethods.hexStringToUIColor(hex:"#EEEEEE")
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        
        let tapOUt = UITapGestureRecognizer(target: self, action: #selector(self.CheckOUtClick(_:)))
        self.first_view.isUserInteractionEnabled = true
        self.first_view.addGestureRecognizer(tapOUt)
        
        let business_tap = UITapGestureRecognizer(target: self, action: #selector(self.businesClick(_:)))
        self.business_view.isUserInteractionEnabled = true
        self.business_view.addGestureRecognizer(business_tap)

        let echo_tap = UITapGestureRecognizer(target: self, action: #selector(self.economyClick(_:)))
        self.economy_view.isUserInteractionEnabled = true
        self.economy_view.addGestureRecognizer(echo_tap)
        
        self.first_class.addTarget(self, action: #selector(self.CheckOUtClick), for: .touchUpInside)
        self.business_img.addTarget(self, action: #selector(self.businesClick), for: .touchUpInside)
        self.eco_img.addTarget(self, action: #selector(self.economyClick), for: .touchUpInside)

    }

    
    @IBAction func plus(_ sender: UIButton) {
        
        if sender.tag == 0{
        
            if adults.text != "9"{
            
                adults.text = "\(Int(adults.text!)!+1)"
            }
        }else if sender.tag == 1{
            
            if childs.text != "5"{
                
                childs.text = "\(Int(childs.text!)!+1)"
            }
        }else if sender.tag == 2{
            
            if infants.text != "5"{
                
                infants.text = "\(Int(infants.text!)!+1)"
            }
        }
        
    }
    
    @IBAction func minus(_ sender: UIButton) {
        
        if sender.tag == 0{
            
            if adults.text != "1"{
                
                adults.text = "\(Int(adults.text!)!-1)"
            }
        }else if sender.tag == 1{
            
            if childs.text != "0"{
                
                childs.text = "\(Int(childs.text!)!-1)"
            }
        }else if sender.tag == 2{
            
            if infants.text != "0"{
                
                infants.text = "\(Int(infants.text!)!-1)"
            }
        }
        
    }
    
    @IBAction func ApplyClick(_ sender: UIBarButtonItem) {
        
        
        let tourInfo = TourInfo(id : "",location: "", date: cabinString,adults: adults.text!,type: "",child : childs.text!,infants : infants.text!)
        
         delegate?.cabinDataTransferM(at : tourInfo)
        _ = self.navigationController?.popViewController(animated: true)
        
  
    }
    
    @objc  func CheckOUtClick(_ sender: UITapGestureRecognizer) {
        
        first_class.setImage(#imageLiteral(resourceName: "marked"), for: .normal)
        business_img.setImage(#imageLiteral(resourceName: "empty_circle"), for: .normal)
        eco_img.setImage(#imageLiteral(resourceName: "empty_circle"), for: .normal)
        self.cabinString = "First"
    }
    @objc  func businesClick(_ sender: UITapGestureRecognizer) {
        
        first_class.setImage(#imageLiteral(resourceName: "empty_circle"), for: .normal)
        business_img.setImage(#imageLiteral(resourceName: "marked"), for: .normal)
        eco_img.setImage(#imageLiteral(resourceName: "empty_circle"), for: .normal)
        self.cabinString = "Business"
    }
    @objc  func economyClick(_ sender: UITapGestureRecognizer) {
        
        first_class.setImage(#imageLiteral(resourceName: "empty_circle"), for: .normal)
        business_img.setImage(#imageLiteral(resourceName: "empty_circle"), for: .normal)
        eco_img.setImage(#imageLiteral(resourceName: "marked"), for: .normal)
        self.cabinString = "Economy"

    }
}
