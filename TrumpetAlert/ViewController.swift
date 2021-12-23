//
//  ViewController.swift
//  TrumpetAlert
//
//  Created by reza wanted on 9/18/1400 AP.
//

import UIKit
import Loaf
import SwiftyJSON

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var sorted = "All"
    
    @IBAction func sort_ac(_ sender: Any) {
        
        var new_list : [String] = []
        for item in list_json {
        
            new_list.append(item["aps"]["sound"].stringValue)
        }
        new_list = new_list.uniqued()
        
        let alert = UIAlertController(title: "SORT", message: "Please Select sort by", preferredStyle: .actionSheet)
           
           alert.addAction(UIAlertAction(title: "All", style: .default , handler:{ (UIAlertAction)in
               print("User click Approve button")
               self.sorted = "All"
               self.sort_bt.setTitle("All", for: .normal)
               self.tableview1.reloadData()
           }))
        for item in new_list {
            let fullNameArr = item.components(separatedBy: ".")
           alert.addAction(UIAlertAction(title: fullNameArr[0], style: .default , handler:{ (UIAlertAction)in
               print("User click Edit button")
               self.sorted = item
               self.sort_bt.setTitle(fullNameArr[0], for: .normal)
               self.tableview1.reloadData()
           }))
        }

         
           
           alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
               print("User click Dismiss button")
           }))

           
           //uncomment for iPad Support
           //alert.popoverPresentationController?.sourceView = self.view

           self.present(alert, animated: true, completion: {
               print("completion block")
           })
    }
    
    @IBOutlet weak var sort_bt: UIButton!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list_json.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.title1.text = list_json[indexPath.row]["aps"]["alert"]["title"].stringValue
        cell.content1.text = list_json[indexPath.row]["aps"]["alert"]["body"].stringValue
        let time = list_json[indexPath.row]["gcm.message_id"].stringValue
        let milisecond = String(time.prefix(13))
        
        print("milisecond is =>",Int(milisecond)?.toDay)
        
        cell.time1.text = Int(milisecond)?.toDay.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sorted == "All" {
            return 100
        }else{
            if sorted == list_json[indexPath.row]["aps"]["sound"].stringValue {
                return 100
            }else{
                return 0
            }
        }
    }
    
    
    
    @IBOutlet weak var tableview1: UITableView! //HomeCell 100
    
    
    let defult = UserDefaults.standard
    @IBOutlet weak var fireBaseId: UILabel!
    @IBAction func copy_ac(_ sender: Any) {
        Loaf("FirebaseID is copyed", state: .success, location: .top, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()
    }
    
    
    @IBAction func refresh_ac(_ sender: Any) {
        fireBaseId.text = "FirebaseID: \(defult.string(forKey: "fcmToken") ?? "please refresh")"
        UIPasteboard.general.string = defult.string(forKey: "fcmToken") ?? "Empty"
        
        
        print("fucking list tilte =>",list_json)
    }
    

    var list_json : [JSON] = []
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fireBaseId.text = "FirebaseID: \(defult.string(forKey: "fcmToken") ?? "please refresh")"
        
        refresh1()
        sort_bt.layer.cornerRadius = sort_bt.layer.frame.height / 4
        sort_bt.layer.masksToBounds = true
        
        NotificationCenter.default.addObserver(self,selector: #selector(refresh1),name: NSNotification.Name(rawValue: "refresh1"),object: nil)
    }

    @objc func refresh1(){
        list_json = getJSON("list_json")?.array ?? []
        list_json = list_json.reversed()
        
        self.tableview1.reloadData()
    }

}




