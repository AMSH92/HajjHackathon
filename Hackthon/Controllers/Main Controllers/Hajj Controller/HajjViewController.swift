//
//  HajjViewController.swift
//  HajjHackathonIOS
//
//  Created by Abdullah Alhaider on 01/08/2018.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit
import MapKit
import Helper4Swift

class HajjViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var borderLineView: UIView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var importantDatesButton: UIButton!
    @IBOutlet weak var whereAmIButton: UIButton!
    @IBOutlet weak var HajjHungerstationButton: UIButton!
    @IBOutlet weak var needHelpButton: UIButton!
    @IBOutlet weak var profileBackView: UIView!
    @IBOutlet weak var todayBackView: UIView!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var campBackView: UIView!
    @IBOutlet weak var campLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    fileprivate lazy var dismissButton: UIButton = {
        let button = UIButton()
        view.addSubview(button)
        button.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70).isActive = true
        button.heightAnchor.constraint(equalToConstant: 110).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        button.backgroundColor = .clear
        return button
    }()
    
    @objc fileprivate func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dismissButton)
        mapEffect()
        setupAtFirst()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func dismissButtonPresed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func profileButtonPresed(_ sender: UIButton) {
        showProfilePage()
    }
     
    @IBAction func WhereAmIPreesed(_ sender: UIButton) {
        showMap()
    }
    
    @IBAction func importantDatesPressed(_ sender: UIButton) {
        showImaportentDates()
    }
    
    @IBAction func HajjHungerstationPressed(_ sender: UIButton) {
        openHungerstation()
    }
    
    @IBAction func exitButton(_ sender: Any) {
        Helper4Swift.shakePhone(style: .light)
        backgroundView.isHidden = false
        exitButton.isHidden = true
        profileButton.isHidden = false
        backgrouncViewUP()
    }
    
    @IBAction func needHelpPresed(_ sender: UIButton) {
        Helper4Swift.shakePhone(style: .light)
        UIView.animate(withDuration: 0.4, animations: {
            self.backgroundView.frame.origin.y = 1500
        }) { (true) in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Hajj", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    
    @objc fileprivate func backgrouncViewUP(){
        UIView.animate(withDuration: 0.4, animations: {
            self.backgroundView.frame.origin.y = 417
            self.backgroundView.alpha = 1
            self.exitButton.alpha = 0
            self.profileImage.alpha = 1
            self.borderLineView.alpha = 1
        })
    }
    
    fileprivate func backgrouncViewDOWN(){
        backgroundView.frame.origin.y = 1500
        UIView.animate(withDuration: 0.4) {
            self.backgroundView.alpha = 0
            self.exitButton.alpha = 1
            self.profileImage.alpha = 0
            self.borderLineView.alpha = 0
        }
    }
    
    fileprivate func mapEffect() {
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.white.withAlphaComponent(1).cgColor]
        mapView.layer.addSublayer(gradientLayer)
    }
    
    fileprivate func showProfilePage() {
        backgrouncViewDOWN()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Hajj", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    fileprivate func showMap() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.backgrouncViewDOWN()
        }) { (true) in
            self.backgroundView.isHidden = true
            self.exitButton.isHidden = false
            self.profileButton.isHidden = true
        }
        
        mapView.showsUserLocation = true
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    fileprivate func showImaportentDates(){
        
        UIView.animate(withDuration: 0.4, animations: {
            self.backgroundView.frame.origin.y = 1500
        }) { (true) in
            let storyBoard: UIStoryboard = UIStoryboard(name: "Hajj", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ImportantDatesViewController") as! ImportantDatesViewController
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    fileprivate func openHungerstation(){
        let openUrl = URL(string: "hungerstation://")
        UIApplication.shared.open(openUrl! , options:[:]) { (success) in
            if !success
            {
                if let url = URL(string: "https://itunes.apple.com/sa/app/hungerstation/id596011949?mt=8"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
        }
    }
    
    fileprivate func setupAtFirst() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(backgrouncViewUP), name: NSNotification.Name(rawValue: "showBackgroundView"), object: nil)
        
        mapView.delegate = self
        
        dismissButton.applyButtonDesign(title: "", titleColor: .black, cornerRadius: 5, backgroundColor: .clear, shadowColor: .clear, shadowRadius: 0, shadowOpacity: 0)

        profileImage.image = "me".asImage
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        profileImage.layer.borderWidth = 1.5
        profileImage.layer.borderColor = UIColor.grayColor.cgColor
        
        profileBackView.layer.cornerRadius = 5
        
        todayBackView.layer.cornerRadius = 5
        todayBackView.backgroundColor = .grayColor
        todayLabel.textColor = .black
        
        campBackView.layer.cornerRadius = 5
        campBackView.backgroundColor = .grayColor
        campLabel.textColor = .black
        
        profileButton.applyViewDesign(masksToBounds: false, shadowColor: .black, cornerRadius: profileButton.frame.size.height / 2, shadowOpacity: 0.3, shadowOffset: CGSize(width: 0, height: 0), shadowRadius: 10)
        
        exitButton.isHidden = true
        exitButton.setImage("exit".asImage, for: .normal)
        exitButton.imageView?.contentMode = .scaleAspectFit
        exitButton.alpha = 0
        
        borderLineView.applyViewDesign(masksToBounds: false, shadowColor: .black, cornerRadius: 10, shadowOpacity: 1, shadowOffset: CGSize(width: 0, height: 0), shadowRadius: 10)
        
        whereAmIButton.backgroundColor = .grayColor
        importantDatesButton.backgroundColor = .grayColor
        HajjHungerstationButton.backgroundColor = .grayColor
        needHelpButton.backgroundColor = .mainColor
        
        whereAmIButton.setTitleColor(.black, for: .normal)
        importantDatesButton.setTitleColor(.black, for: .normal)
        HajjHungerstationButton.setTitleColor(.black, for: .normal)
        needHelpButton.setTitleColor(.white, for: .normal)
        
        backView.layer.cornerRadius = 5
        
        whereAmIButton.layer.cornerRadius = 5
        importantDatesButton.layer.cornerRadius = 5
        HajjHungerstationButton.layer.cornerRadius = 5
        needHelpButton.layer.cornerRadius = 5
    }
    
}

extension HajjViewController: MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
        }
    }
  
}

extension HajjViewController: CLLocationManagerDelegate {
    
}
