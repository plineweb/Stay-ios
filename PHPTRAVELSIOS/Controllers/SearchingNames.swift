





//
//  SearchingNames.swift
//  memuDemo
//
//  Created by APPLE on 02/07/2017.
//  Copyright © 2017 Parth Changela. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Toaster


class SearchingNames: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    @IBOutlet weak var resultTable: UITableView!
    @IBOutlet weak var searching: UISearchBar!
    let preferences = UserDefaults.standard
    let searchkey = "search_hotel"
    let searchkeyTours = "search_tour"
    let searchkeyCarsFrom = "search_car_from"
    let searchkeyExpedia = "search_expedia"
    let searchkeyCarsTo = "search_car_to"
    let searchkeyFlightsFrom = "search_travelport_from"
    let searchkeyFlightTo = "search_travelport_to"
    var singleDate : Bool = false
    
    var dataAry:[AutoCompleteM] = []
    
    var mainArray:[AutoCompleteM] = []
    var url : String = ""
    var check : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white

        if check == "Tours"
        {
            self.url = "\(Constant.domain)/tours/suggestions?appKey=\(Constant.key)&query="
            
            if preferences.object(forKey: searchkeyTours) == nil {
                //  Doesn't exist
            } else {
                
                let decoded : Array  = preferences.array(forKey: searchkeyTours)!
                searching.text = decoded[0] as? String
            }
            self.singleDate = true
            
        } else if check == "Hotels"{
            
            self.url = "\(Constant.domain)hotels/suggestions?appKey=\(Constant.key)&query="
            
            if preferences.object(forKey: searchkey) == nil {
                //  Doesn't exist
            } else {
                
                let decoded : Array  = preferences.array(forKey: searchkey)!
                searching.text = decoded[0] as? String
            }
            self.singleDate = true
            
            
        }
        else if check == "expedia"{
            
            
            if preferences.object(forKey: searchkeyExpedia) == nil {
                
                
            } else {
                let decoded : Array  = preferences.array(forKey: searchkeyExpedia)!
                searching.text = decoded[0] as? String
            }
            
            self.singleDate = true
            
            
        }else if check == "CarTo"{
            
            self.url = "\(Constant.domain)cars/locations?appKey=\(Constant.key)"
            
            if preferences.object(forKey: searchkeyCarsTo) == nil {
                
                
            } else {
                let decoded : Array  = preferences.array(forKey: searchkeyCarsTo)!
                searching.text = decoded[0] as? String
            }
            self.singleDate = false
            
            callToServerCars()
        }else if check == "CarFrom"{
            
            self.url = "\(Constant.domain)cars/locations?appKey=\(Constant.key)"
            
            if preferences.object(forKey: searchkeyCarsFrom) == nil {
                
                
            } else {
                let decoded : Array  = preferences.array(forKey: searchkeyCarsFrom)!
                searching.text = decoded[0] as? String
            }
            self.singleDate = false
            
            callToServerCars()
        }else if check == "travelportfrom"{
            
            self.url = "\(Constant.domain)suggession/airports?appKey=\(Constant.key)&q="
            
            if preferences.object(forKey: searchkeyFlightsFrom) == nil {
                
                
            } else {
                let decoded : Array  = preferences.array(forKey: searchkeyFlightsFrom)!
                searching.text = decoded[0] as? String
            }
            self.singleDate = true
            
        }else if check == "travelportto"{
            
            self.url = "\(Constant.domain)suggession/airports?appKey=\(Constant.key)&q="
            
            if preferences.object(forKey: searchkeyFlightTo) == nil {
                
                
            } else {
                let decoded : Array  = preferences.array(forKey: searchkeyFlightTo)!
                searching.text = decoded[0] as? String
            }
            self.singleDate = true
        }
        
        
        resultTable.delegate = self
        resultTable.dataSource = self
        searching.delegate = self
        
    }
    
    
    func callToServer(ch : String)
    {
        let urlF : String = "\(self.url)\(ch)"
        
        NetworkManager.sharedInstance.requestGETURL(urlF, success: { (json) in
            
            var mainJsonArray = json["response"]
            
            self.mainArray.removeAll()
            
            
            for index in 0..<mainJsonArray.count {
                
                var indexObject = mainJsonArray[index]
                let a = AutoCompleteM(name: indexObject["text"].stringValue,type:indexObject["module"].stringValue ,id: indexObject["id"].stringValue)
                
                self.mainArray.append(a)
                
                self.resultTable.reloadData()
            }
            
            
            
        }) { (error) in
            
            Toast.init(text: error.localizedDescription).show()
        }

        
        
        }
    func callToServerTravelPort(ch : String)
    {
        let urlF : String = "\(self.url)\(ch)"
        
        NetworkManager.sharedInstance.requestGETURL(urlF, success: { (json) in
            
            var mainJsonArray = json["response"]
            
            self.mainArray.removeAll()
            
            
            for index in 0..<mainJsonArray.count {
                
                var indexObject = mainJsonArray[index]
                let a = AutoCompleteM(name: indexObject["text"].stringValue,type:indexObject["countryCode"].stringValue ,id: indexObject["id"].stringValue)
                
                self.mainArray.append(a)
                
            }
          self.resultTable.reloadData()
            
            
        }) { (error) in
            
            Toast.init(text: error.localizedDescription).show()
        }
        
        
        
    }
    func callToServerCars()
    {
        let urlC : String = "\(Constant.domain)cars/locations?appKey=\(Constant.key)"
        
        
        NetworkManager.sharedInstance.requestGETURL(urlC, success: { (json) in
            
            var mainArray = json["response"]
            if self.check == "CarFrom"{
                
                mainArray = mainArray["pickupLocations"]
                
                
            }else  {
                
                mainArray = mainArray["dropoffLocations"]
                print(mainArray)
                
            }
            
            for index in 0..<mainArray.count {
                
                var indexObject = mainArray[index]
                let a = AutoCompleteM(name: indexObject["name"].stringValue,type: "location",id: indexObject["id"].stringValue)
                
                self.mainArray.append(a)
                self.dataAry.append(a)
                
                self.resultTable.reloadData()
            }

            
            
        }) { (error) in
            
            Toast.init(text: error.localizedDescription).show()
        }
    }
    
    
    func callToServerExpedia(ch : String)
    {
        let urlF : String = "http://yasen.hotellook.com/autocomplete?lang=en-US&limit=10&term=\(ch)"
        print("url",urlF)
        
        NetworkManager.sharedInstance.requestGETURL(urlF, success: { (json) in
            
            
            var mainJsonArray = json["cities"]
            
            self.mainArray.removeAll()
            
            
            for index in 0..<mainJsonArray.count {
                
                var indexObject = mainJsonArray[index]
                let a = AutoCompleteM(name: indexObject["fullname"].stringValue,type:indexObject["countryCode"].stringValue ,id : "")
                
                self.mainArray.append(a)
                
                self.resultTable.reloadData()
            }
            
            
            
        }) { (error) in
            
            Toast.init(text: error.localizedDescription).show()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.mainArray.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "autocell", for: indexPath) as! SearchHotelCell
        
        cell.Ptlabel.text = self.mainArray[indexPath.row].name
     
        
        if check == "expedia" || check == "travelportfrom" || check == "travelportto"{
            let bundle = "assets.bundle/"
            cell.ptImage.image =
            
            UIImage(named: bundle + self.mainArray[indexPath.row].type.lowercased() + ".png", in: Bundle(for: SearchingNames.self), compatibleWith: nil)
        }else {
            
            if self.mainArray[indexPath.row].type == "location"
            {
                cell.ptImage.image = #imageLiteral(resourceName: "location_search")
                
            }else{
                
                cell.ptImage.image = #imageLiteral(resourceName: "hotel_search")
            }
            
            
        }
        
        
        
        return cell
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if singleDate {
            
            if check == "expedia"{
                
                callToServerExpedia(ch: searchText)

                
            }else if check == "travelportfrom" || check == "travelportto"{
                
                callToServerTravelPort(ch: searchText)
                
                
            }else{
                
                callToServer(ch: searchText)

            }
            
            
            
        }else{
            
            
            filterTableView(text:searchText)
            
            
            
        }
        
    }
    func filterTableView(text:String) {
        //fix of not searching when backspacing
        if text == ""{
            self.mainArray = self.dataAry
            
        }else {
            self.mainArray = self.dataAry
            self.mainArray = self.dataAry.filter({ (mod) -> Bool in
                return mod.name.lowercased().contains(text.lowercased())
            })
            
        }
        
        self.resultTable.reloadData()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let ac : AutoCompleteM = self.mainArray[indexPath.row]
        
        var auto_array = [String]()
        
        if check == "Tours"
        {
            
            
            auto_array.append(ac.name)
            auto_array.append(ac.type)
            auto_array.append("\(ac.id)")
            preferences.set(auto_array, forKey: searchkeyTours)
            preferences.synchronize()
            
            
            
        }else if check == "Hotels"{
            
            
            auto_array.append(ac.name)
            auto_array.append(ac.type)
            auto_array.append("\(ac.id)")
            preferences.set(auto_array, forKey: searchkey)
            preferences.synchronize()
            
        }else if check == "CarFrom"{
            
            
            auto_array.append(ac.name)
            auto_array.append(ac.type)
            auto_array.append("\(ac.id)")
            preferences.set(auto_array, forKey: searchkeyCarsFrom)
            preferences.synchronize()
        }else if check == "CarTo"{
            
            
            auto_array.append(ac.name)
            auto_array.append(ac.type)
            auto_array.append("\(ac.id)")
            preferences.set(auto_array, forKey: searchkeyCarsTo)
            preferences.synchronize()
            
        }else if check == "expedia"{
            
            
            auto_array.append(ac.name)
            auto_array.append(ac.type)
            auto_array.append("\(ac.id)")
            preferences.set(auto_array, forKey: searchkeyExpedia)
            preferences.synchronize()
        }else if check == "travelportfrom"{

            auto_array.append(ac.name)
            auto_array.append(ac.type)
            auto_array.append("\(ac.id)")
            preferences.set(auto_array, forKey: searchkeyFlightsFrom)
            preferences.synchronize()
            
        }else if check == "travelportto"{
            
            auto_array.append(ac.name)
            auto_array.append(ac.type)
            auto_array.append("\(ac.id)")
            preferences.set(auto_array, forKey: searchkeyFlightTo)
            preferences.synchronize()
            
        }
        
        _ = navigationController?.popViewController(animated: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
}


