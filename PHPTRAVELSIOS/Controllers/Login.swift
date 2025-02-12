

import UIKit
import SVProgressHUD
import Toaster

class Login: UIViewController {

    
    @IBOutlet weak var sign_up: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!

    @IBOutlet weak var menu: UIBarButtonItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        revealViewController().rearViewRevealWidth = 275
        menu.target = revealViewController()
        menu.action = #selector(SWRevealViewController.revealToggle(_:))
        navigationController?.navigationBar.barTintColor =  CommonMethods.hexStringToUIColor(hex: "#2E3192")
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.CheckInClick(_:)))
        
        self.sign_up.isUserInteractionEnabled = true
        
        self.sign_up.addGestureRecognizer(tap)
        
    }
    
    func CheckInClick(_ sender: UITapGestureRecognizer) {
        
        self.performSegue(withIdentifier: "register", sender: self)

       
    }

    @IBAction func Login(_ sender: UIButton) {
    
        
        if (email.text?.isEmpty)! || (password.text?.isEmpty)! {
            
            let toast = Toast(text: "Please Fill The Above Requirments")
            toast.show()
            
 
        }else {
            
            let p : [String:String] = ["email":"\(email.text!)" ,"password":"\(password.text!)"]
            
            
            SVProgressHUD.setForegroundColor(.white)
            SVProgressHUD.show(withStatus: "Loading")
            SVProgressHUD.setBackgroundColor(CommonMethods.hexStringToUIColor(hex: "#2E3192"))

            NetworkManager.sharedInstance.requestPOSTURL("\(Constant.domain)login/check?appKey=\(Constant.key)", params: p, success: { (json) in
                
                var login_arr = [String]()

               
                if json["response"].bool! {
                    
                    let jsonObject = json["userInfo"]
                    
                    login_arr.append("true")
                    login_arr.append(jsonObject["email"].stringValue)
                    login_arr.append(jsonObject["id"].stringValue)
                    login_arr.append("\(jsonObject["firstName"].stringValue) \(jsonObject["lastName"].stringValue)")
                    
                    CommonMethods.preferences.set(login_arr, forKey: "login")
                    
                    CommonMethods.preferences.synchronize()
                    
                    self.performSegue(withIdentifier: "show_main_login", sender: self)
                    
                }else{
                    
                    let error_object = json["error"]
                    
                    login_arr.append("false")
                    login_arr.append("")
                    login_arr.append(error_object["msg"].stringValue)
                    login_arr.append("")
                    
                    self.view.endEditing(true)
                    
                    Toast(text: login_arr[2]).show()

                    
                }
                
                SVProgressHUD.dismiss()
                
                
            }) { (error) in
                
                SVProgressHUD.dismiss()
                Toast.init(text : error.localizedDescription).show()
            }
        
        }
        
  
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
