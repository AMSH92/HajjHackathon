//
//  ViewController.swift
//  HajjHackathonIOS
//
//  Created by Alsharif Abdullah on 01/08/2018.
//  Copyright © 2018 Alsharif Abdullah. All rights reserved.
//

import UIKit
import FirebaseMessaging
import Helper4Swift

class ViewController: UIViewController,MessagingDelegate {
    
    @IBOutlet weak var backStackView: UIStackView!
    
    @IBOutlet weak var hajjOutlet: UIButton!
    @IBOutlet weak var hajjAdminOutlet: UIButton!
    @IBOutlet weak var hajjManagmentOutlet: UIButton!
    
    @IBOutlet weak var view1: UIVisualEffectView!
    @IBOutlet weak var view2: UIVisualEffectView!
    @IBOutlet weak var view3: UIVisualEffectView!
    
    //typealias choice = () -> ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
        animate()
    }
    
    
    // should implement the code for the QR
    @IBAction func hajjAction(_ sender: Any) {
        alert(debug: {
            self.choice(view: .hajjView, state: .debug)
        }) {
            self.choice(view: .hajjView, state: .release)
        }
    }
    
    @IBAction func hajjManagmentAction(_ sender: Any) {
        alert(debug: {
            self.choice(view: .hajjManagmentView, state: .debug)
        }) {
            self.choice(view: .hajjManagmentView, state: .release)
        }
    }
    
    @IBAction func hajjAdminAction(_ sender: Any) {
        alert(debug: {
            self.choice(view: .orgnaizationView, state: .debug)
        }) {
            self.choice(view: .orgnaizationView, state: .release)
        }
    }
    
    @IBAction func IneedHelpAction(_ sender: Any) {
        let storyboad = UIStoryboard(name: "Orgnaization", bundle: nil)
        let nextVC = storyboad.instantiateViewController(withIdentifier: "OrgnaizerMainViewController") as! OrgnaizerMainViewController
        self.present(nextVC, animated: true, completion: nil)
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("FCM Token:", fcmToken)
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    func setup(){
        Messaging.messaging().delegate = self
        backStackView.alpha = 0
        view1.clipsToBounds = true
        view2.clipsToBounds = true
        view3.clipsToBounds = true
        view1.layer.cornerRadius = 6
        view2.layer.cornerRadius = 6
        view3.layer.cornerRadius = 6
    }
    
    fileprivate func animate(){
        UIView.animate(withDuration: 1) {
            self.backStackView.alpha = 1
        }
    }
    
    enum choiceToUse {
        case debug
        case release
    }
    
    enum view {
        case hajjView
        case orgnaizationView
        case hajjManagmentView
    }
    
    fileprivate func alert(debug: @escaping () -> (), release: @escaping () -> ()) {
        
        let alert = UIAlertController(title: "اختر", message: "حدد طريقة دخولك ..", preferredStyle: .alert)
        let debug = UIAlertAction(title: "باستخدام QR", style: .default) { (alert) in
            debug()
        }
        let release = UIAlertAction(title: "مباشرة", style: .default) { (alert) in
            release()
        }
        let cancel = UIAlertAction(title: "الغاء", style: .cancel, handler: nil)
        
        alert.addAction(debug)
        alert.addAction(release)
        alert.addAction(cancel)
        Helper4Swift.shakePhone(style: .medium)
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func choice(view: view, state: choiceToUse){
        
        switch view {
            
        case .hajjView:
            switch state {
                
            case .debug:
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "QRViewController") as! QRViewController
                nextVC.nextView = "view1"
                self.present(nextVC, animated: true, completion: nil)
                
            case .release:
                let storyBoard: UIStoryboard = UIStoryboard(name: "Hajj", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "HajjViewController") as! HajjViewController
                self.present(newViewController, animated: true, completion: nil)
            }
            
        case .hajjManagmentView:
            switch state {
                
            case .debug:
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "QRViewController") as! QRViewController
                nextVC.nextView = "view2"
                self.present(nextVC, animated: true, completion: nil)
                
            case .release:
                let storyBoard: UIStoryboard = UIStoryboard(name: "HajjManagment", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "HajjMangViewController") as! HajjMangViewController
                self.present(newViewController, animated: true, completion: nil)
            }
            
        case .orgnaizationView:
            switch state {
                
            case .debug:
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "QRViewController") as! QRViewController
                nextVC.nextView = "view3"
                self.present(nextVC, animated: true, completion: nil)
                
            case .release:
                let storyBoard: UIStoryboard = UIStoryboard(name: "Orgnaization", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrgnaizerMainViewController") as! OrgnaizerMainViewController
                self.present(newViewController, animated: true, completion: nil)
            }
            
        }
        
        
    }
    
    
}
