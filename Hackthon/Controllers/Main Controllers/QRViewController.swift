//
//  QRViewController.swift
//  HajjHackathonIOS
//
//  Created by Alsharif Abdullah on 01/08/2018.
//  Copyright © 2018 Alsharif Abdullah. All rights reserved.
//

import UIKit
import QRCodeReader
import AVFoundation
import Helper4Swift

let baseurl = "https://flextubeapp.com"


class QRViewController: UIViewController, QRCodeReaderViewControllerDelegate {
    typealias JSONDictionary = [String: Any]

    var nextView: String = ""
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()

    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        self.view.addSubview(indicator)
        indicator.activityIndicatorViewStyle = .gray
        indicator.center = view.center
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readerVC.delegate = self
        self.view.addSubview(readerVC.view)


    }

    @IBAction func scanAction(_ sender: AnyObject) {
        // Retrieve the QRCode content
        // By using the delegate pattern
        
        // Or by using the closure pattern
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            print(result ?? "")
            let generateHamalhURL = URL(string: "\(baseurl)/generate-hamlat-account")
        }
        
        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        print("didScan")
        self.showHUD()
        Helper4Swift.shakePhone(style: .light)

       // reader.stopScanning()
        let header = ["token":result.value]
        
        let params = ["name": "Testing",
                      "email":"Testing@testing.com"
        ]
        let url = URL(string: "\(baseurl)/generate-hamlat-account")
        Request.system.request(url: (url?.description)!, method: .post, params: params, headers: header) { (result) in
            if let results = result as? JSONDictionary {
                if self.nextView == "view1" {
                    let message = results["message"] as! String
                    if message == "Token is invalid!" {
                        self.dismiss(animated: true, completion: {
                            self.alert("We don't recognize this bar code!")
                        })
                    }
                    else {
                        let storyboad = UIStoryboard(name: "Hajj", bundle: nil)
                        let nextVC = storyboad.instantiateViewController(withIdentifier: "HajjViewController") as! HajjViewController
                        self.indicator.stopAnimating()
                        self.indicator.hidesWhenStopped = true
                        self.present(nextVC, animated: true, completion: {
                            self.alert("مرحبا! تم الدخول بنجاح")
                        })
                    }
                    
                }
                else if self.nextView == "view2" {
                    
                    let message = results["message"] as! String
                    if message == "Token is invalid!" {
                        self.dismiss(animated: true, completion: {
                            self.alert("We don't recognize this bar code!")
                        })
                    }
                    else {
                        let storyboad = UIStoryboard(name: "HajjManagment", bundle: nil)
                        let nextVC = storyboad.instantiateViewController(withIdentifier: "HajjMangViewController") as! HajjMangViewController
                        self.indicator.stopAnimating()
                        self.indicator.hidesWhenStopped = true
                        self.present(nextVC, animated: true, completion: {
                            self.alert("مرحبا! تم الدخول بنجاح")
                        })                    }
                 
                }
                else if self.nextView == "view3" {
                    let message = results["message"] as! String
                    if message == "Token is invalid!" {
                        self.dismiss(animated: true, completion: {
                            self.alert("We don't recognize this bar code!")
                        })
                    }
                    else {
                        let storyboad = UIStoryboard(name: "Orgnaization", bundle: nil)
                        let nextVC = storyboad.instantiateViewController(withIdentifier: "OrgnaizerMainViewController") as! OrgnaizerMainViewController
                        self.indicator.stopAnimating()
                        self.indicator.hidesWhenStopped = true
                        self.present(nextVC, animated: true, completion: {
                            self.alert("مرحبا! تم الدخول بنجاح")
                        })                    }
                }
            }
        }
        
 
        print(result.value)
        
    }
    
    //This is an optional delegate method, that allows you to be notified when the user switches the cameraName
    //By pressing on the switch camera button
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        if let cameraName = newCaptureDevice.device.localizedName as? String{
            print("Switching capturing to: \(cameraName)")
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }

}
