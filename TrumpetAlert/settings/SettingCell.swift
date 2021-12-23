//
//  SettingCell.swift
//  TrumpetAlert
//
//  Created by reza wanted on 9/18/1400 AP.
//

import UIKit

class SettingCell: UITableViewCell {
    
    @IBOutlet weak var swich1: UISwitch!
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var play_ac: UIButton!
    
    @IBAction func play_bt(_ sender: Any) {
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
