//
//  Extensions.swift
//  HajjHackathonIOS
//
//  Created by Abdullah Alhaider on 01/08/2018.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit

extension String {
    var asImage: UIImage {
        return UIImage(named: self) ?? UIImage()
    }
    
    var loclized: String {
        return NSLocalizedString(self, comment: "")
    }
}
