//
//  InfoViewController.swift
//  Hackthon
//
//  Created by Alsharif Abdullah on 02/08/2018.
//  Copyright © 2018 Alsharif Abdullah. All rights reserved.
//

import UIKit
import UserNotifications
import FaceAware

class InfoTableViewCell: UITableViewCell {
    @IBOutlet weak var ticketLabel: UILabel!
    
}
class InfoViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var tablwView: UITableView!
    @IBOutlet weak var currentView: UIView!
    
    var tickets: [String] = ["حاج مفقود","حاج يحتاج الاسعاف","طلب الامن"]
    var searchPerson: [String] = ["حاج مفقود"]

    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)

    var selectedView: String = ""
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        view.addSubview(indicator)
        indicator.activityIndicatorViewStyle = .gray
        indicator.center = view.center
        return indicator
    }()
    var panGestureRecognizer: UIPanGestureRecognizer?
    var originalPosition: CGPoint?
    var currentPositionTouched: CGPoint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.startAnimating()
        self.tablwView.reloadData()
        self.currentView.clipsToBounds = true
        currentView.layer.cornerRadius = 15
        self.indicator.stopAnimating()
        self.indicator.hidesWhenStopped = true
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        view.addGestureRecognizer(panGestureRecognizer!)
    }
    

    @objc func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        
        if panGesture.state == .began {
            originalPosition = view.center
            currentPositionTouched = panGesture.location(in: view)
        } else if panGesture.state == .changed {
            view.frame.origin = CGPoint(
                x: translation.x,
                y: translation.y
            )
        } else if panGesture.state == .ended {
            let velocity = panGesture.velocity(in: view)
            
            if velocity.y >= 1500 {
                UIView.animate(withDuration: 0.2
                    , animations: {
                        self.view.frame.origin = CGPoint(
                            x: self.view.frame.origin.x,
                            y: self.view.frame.size.height
                        )
                }, completion: { (isCompleted) in
                    if isCompleted {
                        self.dismiss(animated: true, completion: {
                             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showBackgroundView"), object: nil)
                        })
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.center = self.originalPosition!
                })
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if let imageData = image.jpeg(.lowest) {
                let imageView = UIImageView()
                imageView.image = UIImage(data: imageData)
                imageView.focusOnFaces = true
               
                let url = "\(baseurl)/detect-face"
                let parm = ["photo": imageData] as [String : Any]
               print(imageData)
                Request.system.request(url: url, method: .post, params: parm, headers: nil) { (result) in
                    if let results = result as? JSONDictionary {
                        self.alert("\(results)")
                        self.dismiss(animated: true) {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showBackgroundView"), object: nil)
                        }
                    }
                }
                
            }
            
            
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
extension InfoViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.selectedView ==  "view2" {
            return searchPerson.count
        }
        return tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as? InfoTableViewCell {
            if self.selectedView ==  "view2" {
                cell.ticketLabel.text = self.searchPerson[indexPath.row]

            }
            cell.ticketLabel.text = self.tickets[indexPath.row]
            return cell 
            }
        return UITableViewCell()
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selectedView ==  "view2" {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)

        }
        else {
            self.alert("تم التبليغ بنجاح")
            self.dismiss(animated: true) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showBackgroundView"), object: nil)
            }
        }
       
    }
    
}
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    func jpeg(_ quality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
}
