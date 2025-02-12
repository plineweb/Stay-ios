//
//  menuViewController.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit

class menuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblTableView: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!

    @IBOutlet weak var profile_email: UILabel!

    var checkExpend : Bool = false
    
    var ManuNameArray = [NameImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        self.ManuNameArray.append(NameImage(name: "Home",img: "",UIimg: #imageLiteral(resourceName: "ic_home")))
        self.ManuNameArray.append(NameImage(name: "Login/Register",img: "",UIimg: #imageLiteral(resourceName: "login")))
        self.ManuNameArray.append(NameImage(name: "Check Invoice",img: "",UIimg: #imageLiteral(resourceName: "check_invoice")))

        for i in 0..<CommonMethods.ModeluArray.count {
        
            if CommonMethods.ModeluArray[i].title == "blog"
            {
                print("My Array = \(CommonMethods.ModeluArray[1].title)")
                
                self.ManuNameArray.append(NameImage(name: "Blog",img: "",UIimg: #imageLiteral(resourceName: "ic_blog")))
                
            }
            if CommonMethods.ModeluArray[i].title=="offers"
            {
                self.ManuNameArray.append(NameImage(name: "Offers",img: "",UIimg: #imageLiteral(resourceName: "offers")))
            }
        
        }
        
        self.ManuNameArray.append(NameImage(name: "Contact Us",img: "",UIimg: #imageLiteral(resourceName: "ic_contats")))
        self.ManuNameArray.append(NameImage(name: "About",img: "",UIimg: #imageLiteral(resourceName: "ic_about")))
        self.ManuNameArray.append(NameImage(name: "Exit",img: "",UIimg: #imageLiteral(resourceName: "exit")))

        if CommonMethods.preferences.object(forKey: "login") == nil {
            //  Doesn't exist
        } else {
          
            let user : [String] =  CommonMethods.preferences.array(forKey: "login") as! [String]
            profile_email.text = user[1]
            ManuNameArray[1].name = "My Account"
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManuNameArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        cell.lblMenuname.text! = ManuNameArray[indexPath.row].name
        cell.imgIcon.image = ManuNameArray[indexPath.row].UIimg
        
        if ManuNameArray[indexPath.row].name == "My Booking" || ManuNameArray[indexPath.row].name == "My Profile" || ManuNameArray[indexPath.row].name == "LOGOUT"
        {
          cell.backgroundColor = CommonMethods.hexStringToUIColor(hex: "#EEEEEE")
            
        }else{
        
            cell.backgroundColor = .white
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let revealviewcontroller:SWRevealViewController = self.revealViewController()
        
        let cell:MenuCell = tableView.cellForRow(at: indexPath) as! MenuCell
        print(cell.lblMenuname.text!)
        if cell.lblMenuname.text! == "Home"
        {
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "maintab") as! MainTabBar
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            self.revealViewController().pushFrontViewController(newFrontController, animated: true)
            
        }
        else if cell.lblMenuname.text! == "LOGOUT"
        {
            
            CommonMethods.preferences.removeObject(forKey: "login")
            CommonMethods.preferences.synchronize()

            ManuNameArray[1].name = "Login/Register"

            ManuNameArray.remove(at: 2)
            ManuNameArray.remove(at: 2)
            ManuNameArray.remove(at: 2)
            
            tblTableView.reloadData()
            
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "maintab") as! MainTabBar
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            self.revealViewController().pushFrontViewController(newFrontController, animated: true)
            
            
        }
        else if cell.lblMenuname.text! == "Check Invoice"
        {
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "check_invoice") as! CheckInvoice
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            self.revealViewController().pushFrontViewController(newFrontController, animated: true)
            
        }
        else if cell.lblMenuname.text! == "My Account"
        {
            if checkExpend {
            
                ManuNameArray.remove(at: 2)
                ManuNameArray.remove(at: 2)
                ManuNameArray.remove(at: 2)

                tblTableView.reloadData()
                checkExpend = false
            
            }else{
                
                ManuNameArray.insert(NameImage(name: "My Booking", img: "", UIimg: #imageLiteral(resourceName: "ic_booking")),at: 2)
                ManuNameArray.insert(NameImage(name: "My Profile", img: "", UIimg: #imageLiteral(resourceName: "my_profile")),at: 3)
                ManuNameArray.insert(NameImage(name: "LOGOUT", img: "", UIimg: #imageLiteral(resourceName: "logout")),at : 4)

                tblTableView.reloadData()
                checkExpend = true
            
            }
            
        } else if cell.lblMenuname.text! == "My Booking"
        {
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "MyBookingController") as! MyBookingController
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
            
        }       else if cell.lblMenuname.text! == "My Profile"
        {
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
            
        }else if cell.lblMenuname.text! == "About"
        {
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "about") as! AboutUs
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
            
        } else if cell.lblMenuname.text! == "Contact Us"
        {
            print("message Tapped")
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "contact") as! Contactus
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
            
        }  else if cell.lblMenuname.text! == "Offers"
        {
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "OffersController") as! OffersList
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
            
        }
        else if cell.lblMenuname.text! == "Login/Register"
        {
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "login") as! Login
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
        }
      else  if cell.lblMenuname.text! == "Map"
        {
            print("Map Tapped")
        }
        else  if cell.lblMenuname.text! == "Blog"
        {
            let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "bloglist") as! BlogController
            let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
            revealviewcontroller.pushFrontViewController(newFrontController, animated: true)
        }
      else  if cell.lblMenuname.text! == "Exit"
        {
           exit(0)
        }
    }
}
