//
//  HomeCell.swift
//  TrumpetAlert
//
//  Created by reza wanted on 9/18/1400 AP.
//

import UIKit

class HomeCell: UITableViewCell {
    
    
    @IBOutlet weak var time1: UILabel!
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var content1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
