//
//  ProfileViewController.swift
//  Hackthon
//
//  Created by Abdullah Alhaider on 02/08/2018.
//  Copyright © 2018 Alsharif Abdullah. All rights reserved.
//

import UIKit
import Helper4Swift

class ProfileViewController: UIViewController {


    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    
    @IBOutlet weak var exitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func exitButtonPresed(_ sender: UIButton) {
       dismiss()
    }
    
    fileprivate func dismiss(){
        dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showBackgroundView"), object: nil)
        }
    }
    
    fileprivate func setup() {
        view.backgroundColor = .clear
        backView.applyViewDesign(masksToBounds: false, shadowColor: .darkGray, cornerRadius: 10, shadowOpacity: 0.4, shadowOffset: CGSize(width: 0, height: 0), shadowRadius: 12)
        
        profileImage.image = "me".asImage
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        profileImage.layer.borderWidth = 2.5
        profileImage.layer.borderColor = UIColor.grayColor.cgColor
        
        view1.layer.cornerRadius = 5
        view1.backgroundColor = .grayColor
        
        view2.layer.cornerRadius = 5
        view2.backgroundColor = .grayColor
        
        view3.layer.cornerRadius = 5
        view3.backgroundColor = .grayColor
        
        view4.layer.cornerRadius = 5
        view4.backgroundColor = .grayColor
        
        view5.layer.cornerRadius = 5
        view5.backgroundColor = .grayColor
        
        view6.layer.cornerRadius = 5
        view6.backgroundColor = .grayColor
        
        exitButton.layer.cornerRadius = 5
        exitButton.layer.borderWidth = 1
        exitButton.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
    }
    
    
    

}
