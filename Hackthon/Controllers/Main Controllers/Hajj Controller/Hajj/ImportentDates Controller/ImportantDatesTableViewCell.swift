//
//  ImportantDatesTableViewCell.swift
//  HajjHackathonIOS
//
//  Created by Abdullah Alhaider on 01/08/2018.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit
import Helper4Swift

class ImportantDatesTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cus()
    }
    
    fileprivate func cus(){
        backView.applyViewDesign(masksToBounds: false, shadowColor: .darkGray, cornerRadius: 10, shadowOpacity: 0.2, shadowOffset: CGSize(width: 0, height: 0), shadowRadius: 9)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
