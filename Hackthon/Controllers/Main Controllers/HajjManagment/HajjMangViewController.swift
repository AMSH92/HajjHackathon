//
//  HajjMangViewController.swift
//  HajjHackathonIOS
//
//  Created by Alsharif Abdullah on 01/08/2018.
//  Copyright © 2018 Alsharif Abdullah. All rights reserved.
//

import UIKit
import MapKit

class MyPointAnnotation : MKPointAnnotation {
    var pinTintColor: UIColor?
}
class HajjMangViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var checkPointerOutlet: UIButton!
    @IBOutlet weak var orgnaizationsOutlet: UIButton!
    @IBOutlet weak var changeMapView: UIView!
    @IBOutlet weak var numberOfOrgnaizations: UIView!
    @IBOutlet weak var numberOfHujjajView: UIView!
    @IBOutlet weak var trafficPoliceOutlet: UIButton!
    @IBOutlet weak var optionView: UIStackView!
    
    let locationManager = CLLocationManager()
    var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
    let annotation = MKPointAnnotation()
    
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
        setup()
        setLayer()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func setup() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(getStatusViewBack), name: NSNotification.Name(rawValue: "showBackgroundView"), object: nil)
        
        mapView.delegate = self
        locationManager.delegate = self
        
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.frame
        gradientLayer.colors =
            [UIColor.clear.cgColor,UIColor.white.withAlphaComponent(1).cgColor]
        //Use diffrent colors
        self.mapView.layer.addSublayer(gradientLayer)
        
        mapView.setZoomByDelta(delta: 0.5, animated: true)
        mapView.showsUserLocation = true
        
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func setLayer() {
        self.orgnaizationsOutlet.layer.cornerRadius = 5
        self.checkPointerOutlet.layer.cornerRadius = 5
        self.trafficPoliceOutlet.layer.cornerRadius = 5
        self.numberOfHujjajView.layer.cornerRadius = 5
        self.numberOfOrgnaizations.layer.cornerRadius = 5
        self.changeMapView.layer.cornerRadius = 5
        self.orgnaizationsOutlet.backgroundColor = .grayColor
        self.checkPointerOutlet.backgroundColor = .grayColor
        self.trafficPoliceOutlet.backgroundColor = .grayColor
        self.trafficPoliceOutlet.setTitleColor(UIColor.black, for: .normal)
        self.orgnaizationsOutlet.setTitleColor(UIColor.black, for: .normal)
        self.checkPointerOutlet.setTitleColor(UIColor.black, for: .normal)
    }

    @objc func getStatusViewBack(){
        UIView.animate(withDuration: 0.5) {
            self.optionView.frame.origin.y = 542
            
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        } else {
            annotationView?.annotation = annotation
        }
        
        if let annotation = annotation as? MyPointAnnotation {
            annotationView?.pinTintColor = annotation.pinTintColor
        }
        
        return annotationView
    }
    
    @IBAction func checkPointerAction(_ sender: Any) {
        self.checkPointerOutlet.backgroundColor = .mainColor
        self.orgnaizationsOutlet.backgroundColor = .grayColor
        self.trafficPoliceOutlet.backgroundColor = .grayColor
        self.trafficPoliceOutlet.setTitleColor(UIColor.black, for: .normal)
        self.orgnaizationsOutlet.setTitleColor(UIColor.black, for: .normal)
        self.checkPointerOutlet.setTitleColor(UIColor.white, for: .normal)
        
        let randomURL = "https://flextubeapp.com/create-random-point/21.423432/39.8261263/3.5/100"
        Request.system.request(url: randomURL, method: .get, params: nil, headers: nil) { (result) in
            if let results = result as? JSONDictionary {
                let coordinates = results["results"] as! [JSONDictionary]
                for i in coordinates {
                    
                    self.coordinates.append(coordinatesArray(lat: i["new_latitude"] as! Double, long: i["new_longitude"] as! Double))
                    
                }
                for points in self.coordinates {
                    let hellox = MyPointAnnotation()
                    hellox.title = "Hujjaj"
                    hellox.pinTintColor = UIColor.mainColor
                    hellox.coordinate = CLLocationCoordinate2D(latitude: points.lat, longitude: points.long)
                    self.mapView.showAnnotations([hellox], animated: true)
                    self.mapView.addAnnotation(hellox)
                }
                // self.mapView.setZoomByDelta(delta: 1.4, animated: true)
                
                
            }
        }
        
        
        
    }
    
    @IBAction func orgnaizationsAction(_ sender: Any) {
      
        self.checkPointerOutlet.backgroundColor = .grayColor
        self.orgnaizationsOutlet.backgroundColor = UIColor.orange
        self.trafficPoliceOutlet.backgroundColor = .grayColor
        self.trafficPoliceOutlet.setTitleColor(UIColor.black, for: .normal)
        self.orgnaizationsOutlet.setTitleColor(UIColor.white, for: .normal)
        self.checkPointerOutlet.setTitleColor(UIColor.black, for: .normal)
        
        let points = [
            ["title": "حملة الشريف",     "latitude": 21.429435, "longitude": 39.8185223],
            ["title": "حملة العحمي",     "latitude": 21.4294162, "longitude": 39.8199738],
            ["title": "حملة الحيدر",     "latitude": 21.4300892, "longitude": 39.8192238]
        ]
        for point in points {
            let hellox = MyPointAnnotation()
            hellox.title = "Hujjaj"
            hellox.pinTintColor = UIColor.orange
            hellox.coordinate = CLLocationCoordinate2D(latitude: point["latitude"] as! Double, longitude: point["longitude"] as! Double)
            self.mapView.showAnnotations([hellox], animated: true)
            self.mapView.addAnnotation(hellox)
        }

    }
    
    @IBAction func trafficPoliceAction(_ sender: Any) {
        self.checkPointerOutlet.backgroundColor = .grayColor
        self.orgnaizationsOutlet.backgroundColor = .grayColor
        self.trafficPoliceOutlet.backgroundColor = UIColor.red
        self.trafficPoliceOutlet.setTitleColor(UIColor.white, for: .normal)
        self.orgnaizationsOutlet.setTitleColor(UIColor.black, for: .normal)
        self.checkPointerOutlet.setTitleColor(UIColor.black, for: .normal)
        
        let points = [
            ["title": "المرور",     "latitude": 21.4238392, "longitude": 39.8228172],
            ["title": "المرور",     "latitude": 21.420435, "longitude": 39.8267623],
            ["title": "المرور",     "latitude": 21.418872, "longitude": 39.8234583]
        ]
        for point in points {
            let annotation = MKPointAnnotation()
            annotation.title = point["title"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: point["latitude"] as! Double, longitude: point["longitude"] as! Double)
            mapView.addAnnotation(annotation)
            mapView.showAnnotations([annotation], animated: true)

        }

    }
    
    @IBAction func infoAction(_ sender: Any) {
        UIView.animate(withDuration: 0.4, animations: {
            self.optionView.frame.origin.y = 1500
        }) { (ok) in
            if ok {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
                nextVC.selectedView = "view2"
                self.present(nextVC, animated: true, completion: nil)
            }
            else {
                print("ERROR")
            }
        }
    }
    
}
