//
//  CreditCard.swift
//  memuDemo
//
//  Created by Qasim Hussain on 09/10/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Toaster
import SVProgressHUD

class CreditCard: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var credit_card_btn: UIButton!
    @IBOutlet weak var main_view: UIView!
    @IBOutlet weak var poup_background: UILabel!
    @IBOutlet weak var card_number: UILabel!
    @IBOutlet weak var c_holder_name: UILabel!
    @IBOutlet weak var expiray_date: UILabel!
    @IBOutlet weak var expiray_date_year: UILabel!
    
    
    @IBOutlet var congra: UIView!
    @IBOutlet var credit_card: UITableView!
    
    @IBOutlet weak var cvv: UITextField!
    var pas_arr_book : [PasssengerModel] = []
    var cc_arr : [AutoCompleteM] = []
    var p : [String : Any] = [:]

    var p_title : [String] = []
    var p_first : [String] = []
    var p_last : [String] = []
    var p_phone : [String] = []
    var p_nationality : [String] = []
    var p_code : [String] = []
    var p_mtitle : [String] = []
    var p_email : [String] = []

    var cc_value  = ""
    var user_id = "0"


    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.white
      
        self.p.removeAll()
        self.main_view.layer.cornerRadius = 5
        self.main_view.clipsToBounds = true
        
        self.credit_card_btn.layer.cornerRadius = 5
        self.credit_card_btn.clipsToBounds = true
        
        for i in 0..<pas_arr_book.count{
            
            self.p_first.append(pas_arr_book[i].p_first)
            self.p_last.append(pas_arr_book[i].p_last)
            self.p_phone.append(pas_arr_book[i].p_phone)
            self.p_nationality.append(pas_arr_book[i].p_nationality)
            self.p_code.append(pas_arr_book[i].p_code)
            self.p_mtitle.append(pas_arr_book[i].p_mtitle)
            self.p_email.append(pas_arr_book[i].p_email)
        }
        
        cc_arr.append(AutoCompleteM(name: "Mastercard", type: "CA", id: ""))
        cc_arr.append(AutoCompleteM(name: "Visa", type: "VI", id: ""))
        cc_arr.append(AutoCompleteM(name: "American Express", type: "AX", id: ""))
        cc_arr.append(AutoCompleteM(name: "Discover", type: "DS", id: ""))
        
        self.credit_card.delegate = self
        self.credit_card.dataSource = self

    }

   
    @IBAction func CreditCardButton(_ sender: UIButton) {
        
        animateIn()
    }
    
    @IBAction func MonthChanged(_ sender: UITextField) {
        expiray_date.text = sender.text
    }
    @IBAction func ChangedYear(_ sender: UITextField) {
        expiray_date_year.text = sender.text
    }
    
  
    
    @IBAction func ChangeNameText(_ sender: UITextField) {
           c_holder_name.text = sender.text
    }
    @IBAction func ChangeText(_ sender: UITextField) {
        
            card_number.text = sender.text
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.p.removeAll()
    }
    
    @IBAction func BookIt(_ sender: UIButton) {
        
        let url = "\(Constant.domain)travelport/placeorder?appKey=\(Constant.key)"
        
        if CommonMethods.preferences.object(forKey: "login") == nil {
            
            
        } else {
            let user : [String] =  CommonMethods.preferences.array(forKey: "login") as! [String]
            self.user_id = user[2]
        }
        
        
        if self.pas_arr_book.count == 1{
            p = [
                "title[]" : self.p_mtitle[0] ,
                "firstname[]" : self.p_first[0],
                "lastname[]" : self.p_last[0],
                "phone[]" : self.p_phone[0],
                "email[]" : self.p_email[0],
                "nationality[]" : self.p_nationality[0],
                "code[]" : self.p_code[0],
                "formsCount" : "\(self.pas_arr_book.count-1)" as String,
                "cardtype" : cc_value,
                "expMonth" : self.expiray_date.text! ,
                "expYear" : self.expiray_date_year.text! ,
                "cvv" : self.cvv.text!,
                "cardno" : self.card_number.text!,
                "userId" : self.user_id

            ]
            
        }else{
            
            p = [
                "title[]" : self.p_mtitle as [String],
                "firstname[]" : self.p_first as [String],
                "lastname[]" : self.p_last as [String],
                "phone[]" : self.p_phone as [String],
                "email[]" : self.p_email as [String],
                "nationality[]" : self.p_nationality as [String],
                "code[]" : self.p_code as [String],
                "formsCount" : "\(self.pas_arr_book.count)" as String,
                "cardtype" : cc_value,
                "expMonth" : self.expiray_date.text! ,
                "expYear" : self.expiray_date_year.text! ,
                "cvv" : self.cvv.text!,
                "cardno" : self.card_number.text!,
                "userId" : self.user_id
            ]
            
        }
        
       
        SVProgressHUD.setForegroundColor(.white)
        SVProgressHUD.show(withStatus: "Loading")
        SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))
        NetworkManager.sharedInstance.requestPOSTURL(url, params: p, success: { (json) in
            
            if json["status"].stringValue == "success"{
                
                self.view.endEditing(true)

               self.animateBook()
                
                
            }else if json["status"].stringValue == "fail"{
                self.view.endEditing(true)
                Toast(text : "\(json["message"].stringValue)").show()
                //_ = self.navigationController?.popViewController(animated: true)                
            }
            SVProgressHUD.dismiss()
        }) { (error) in
            self.view.endEditing(true)

            Toast(text : "\(error).stringValue)").show()
          //  _ = self.navigationController?.popViewController(animated: true)
            SVProgressHUD.dismiss()
            
        }
    }
    func animateIn() {
        self.view.addSubview(credit_card)
        credit_card.center = self.view.center
        
        credit_card.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        credit_card.alpha = 0
        poup_background.isHidden = false
        
        UIView.animate(withDuration: 0.4) {
            self.credit_card.alpha = 1
            self.credit_card.transform = CGAffineTransform.identity
        }
    }
    
    
    func animateOut () {
        poup_background.isHidden = true
        
        UIView.animate(withDuration: 0.3, animations: {
            self.credit_card.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.credit_card.alpha = 0
            
            
        }) { (success:Bool) in
            self.credit_card.removeFromSuperview()
        }
    }
    func animateBook() {
        self.view.addSubview(self.congra)
        self.congra.center = self.view.center
        
        self.congra.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.congra.alpha = 0
        poup_background.isHidden = false
        
        UIView.animate(withDuration: 0.4) {
            self.congra.alpha = 1
            self.congra.transform = CGAffineTransform.identity
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cc_arr.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=UITableViewCell()
 
            cell.textLabel?.text = cc_arr[indexPath.row].name
        
        return cell
        
    }
    
    @IBAction func BackToHome(_ sender: UIButton) {
        
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "maintab") as! MainTabBar
        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
        self.revealViewController().pushFrontViewController(newFrontController, animated: true)
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
            credit_card_btn.setTitle(cc_arr[indexPath.row].name, for: .normal)
        
            cc_value = cc_arr[indexPath.row].type
        
           animateOut()
        
    }

}
