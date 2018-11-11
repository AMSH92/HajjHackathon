//
//  HelpTableViewCell.swift
//  HajjHackathonIOS
//
//  Created by Abdullah Alhaider on 02/08/2018.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit

class HelpTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
