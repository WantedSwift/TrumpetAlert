//
//  SettingView.swift
//  TrumpetAlert
//
//  Created by reza wanted on 9/18/1400 AP.
//

import UIKit
import AVFoundation


class SettingView: UIViewController,UITableViewDelegate,UITableViewDataSource, AVAudioPlayerDelegate {
    
    var audioPlayer: AVAudioPlayer?
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        indexed = 99999
        tableview1.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names_file.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview1.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
        cell.name1.text = names_file[indexPath.row]
        cell.play_ac.tag = indexPath.row
        cell.play_ac.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
        cell.swich1.isOn = status_file[indexPath.row]
        cell.swich1.tag = indexPath.row
        
        cell.swich1.addTarget(self, action:  #selector(swich(sender:)), for: .valueChanged)
        
        if indexed == indexPath.row {
            cell.play_ac.setImage(UIImage(named: "pause"), for: .normal)
        }else{
            cell.play_ac.setImage(UIImage(named: "play"), for: .normal)
        }

        
        return cell
    }
    
    
    var indexed = 99999
    var player: AVAudioPlayer?
    
    @objc func swich(sender: UISwitch){
        status_file[sender.tag] = !status_file[sender.tag]
        tableview1.reloadData()
        defult.set(status_file, forKey: "status_file")
        
        if status_file[sender.tag] {
            
        }else{
            
        }
        
    }
    
    @objc func connected(sender: UIButton){
        print("i am sender =>", sender.tag)
        indexed = sender.tag
        
        player?.stop()
        
        guard let url = Bundle.main.url(forResource: names_file[sender.tag], withExtension: "mp3") else { return }

            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)

                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                
                guard let player = player else { return }
                player.delegate = self
                player.play()
                self.tableview1.reloadData()

            } catch let error {
                print(error.localizedDescription)
            }
        
    }
                        
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
    
    
    
    @IBOutlet weak var tableview1: UITableView! //SettingCell 61
    
    
    var names_file = ["ACCESSGRANTED",    "GUITAR",        "NEWSFLASH",
                      "ALERT",        "GUNSHOOT",        "NOTIFY",
                      "ALERTALERT",        "HAPPYBALE",        "OPENEYE",
                      "BOUGHT",        "HAPPYBD",        "PILLS",
                      "BULLET",        "HAPPYMELODY",        "PRICEINCREASE",
                      "CAR",            "HELLO",        "RECEIVED",
                      "CASH",        "HELLOHUMAN",        "RING",
                      "CHILL",        "HELLOVOICE",        "RING2",
                      "CHRISTMAS",        "HIGHALERT",        "RING3",
                      "COMPLETED",        "HIPRICEGAP",        "SHOCKMOVE",
                      "CONSEQUENCE",        "JAPANESE",        "SHORT",
                      "CUTE",        "JINGELBELLS",        "SOLD",
                      "DING",        "JUMP",        "SPREADALERT",
                      "DING2",        "MEETING1H",        "STOCKBELL",
                      "DOUBLERING",        "MEETING30M",        "STORM",
                      "DRINKWATER",        "MESSAGE",        "TEENEG",
                      "FORGETCALL",        "MEXICAN",        "WAKEUP",
                      "GOODMORNING",        "MEXICANYELL",        "WAVY",
                      "GOODMORNING2",    "NEWSCHANNEL"
    ]
    
    
    let defult = UserDefaults.standard
    var status_file = [true,    true,        true,
                      true,    true,        true,
                      true,    true,        true,
                      true,    true,        true,
                      true,    true,        true,
                      true,    true,        true,
                      true,    true,        true,
                      true,    true,        true,
                      true,    true,        true,
                      true,    true,        true,
                      true,    true,        true,
                      true,    true,        true,
                      true,    true,        true,
                      true,    true,        true,
                      true,    true,        true,
                      true,    true,        true,
                      true,    true,        true,
                      true,    true,        true,
                      true,    true
    ]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        names_file = names_file.sorted()
        
        if defult.array(forKey: "status_file") != nil {
            status_file = defult.array(forKey: "status_file") as! [Bool]
        }else{
            defult.set(status_file, forKey: "status_file")
        }
        tableview1.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
