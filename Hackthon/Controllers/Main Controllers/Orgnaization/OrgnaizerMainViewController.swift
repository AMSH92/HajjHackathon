//
//  OrgnaizerMainViewController.swift
//  Hackthon
//
//  Created by Alsharif Abdullah on 01/08/2018.
//  Copyright © 2018 Alsharif Abdullah. All rights reserved.
//

import UIKit
import MapKit
import UserNotifications
import Alamofire
class OrgnaizerMainViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var statusStackView: UIStackView!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var statusText: UITextView!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var numberOfHujjajView: UIView!
    @IBOutlet weak var numberOfKhyamView: UIView!
    
    var location: CLLocation?
    let locationManager = CLLocationManager()
    
    struct coordinatesArray {
        let lat: Double
        let long: Double
    }
    var coordinates: [coordinatesArray] = []

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
        self.mapView.delegate = self
        locationManager.delegate = self
        getRandom()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        setupLayer()
    }
    
    
    func getRandom() {
        let randomURL = "https://flextubeapp.com/create-random-point/21.4238390/39.8223072/0.5/100"
        Request.system.request(url: randomURL, method: .get, params: nil, headers: nil) { (result) in
            if let results = result as? JSONDictionary {
                let coordinates = results["results"] as! [JSONDictionary]
                for i in coordinates {
                    
                    self.coordinates.append(coordinatesArray(lat: i["new_latitude"] as! Double, long: i["new_longitude"] as! Double))

                }
                for points in self.coordinates {
                    let annotation = MKPointAnnotation()
                    annotation.title = "Hujjaj"
                    annotation.coordinate = CLLocationCoordinate2D(latitude: points.lat, longitude: points.long)
                    self.mapView.showAnnotations([annotation], animated: true)
                    
                }
               // self.mapView.setZoomByDelta(delta: 1.4, animated: true)
                
                
            }
        }
    }

    func setupLayer(){
        self.statusView.layer.cornerRadius = 6
        self.numberOfHujjajView.layer.cornerRadius = 6
        self.numberOfKhyamView.layer.cornerRadius = 6
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.colors =
            [UIColor.clear.cgColor,UIColor.white.withAlphaComponent(1).cgColor]
        self.mapView.layer.addSublayer(gradientLayer)
        addRadiusCircle(location: CLLocation(latitude: self.mapView.userLocation.coordinate.longitude , longitude: self.mapView.userLocation.coordinate.latitude ))
        NotificationCenter.default.addObserver(self, selector: #selector(getStatusViewBack), name: NSNotification.Name(rawValue: "showBackgroundView"), object: nil)


    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addRadiusCircle(location: CLLocation){
        let circle = MKCircle(center: location.coordinate, radius: 20)
        self.mapView.add(circle)
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer : MKCircleRenderer = MKCircleRenderer(overlay: overlay);
        circleRenderer.strokeColor = UIColor.red
        circleRenderer.fillColor = UIColor(red: 0.0, green: 0.0, blue: 0.7, alpha: 0.5)
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }
    
 //542
   @objc func getStatusViewBack(){
        UIView.animate(withDuration: 0.5) {
            self.statusStackView.frame.origin.y = 542

        }
    }
    @IBAction func infoAction(_ sender: Any) {
        print("Rrr")
        UIView.animate(withDuration: 0.4, animations: {
            self.statusStackView.frame.origin.y = 1500
        }) { (ok) in
            if ok {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
                self.present(nextVC, animated: true, completion: nil)
            }
            else {
                print("ERROR")
            }
        }
    }
    

    
    
}

