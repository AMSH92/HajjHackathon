//
//  Config.swift
//  HajjHackathonIOS
//
//  Created by Alsharif Abdullah on 01/08/2018.
//  Copyright © 2018 Alsharif Abdullah. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import SwiftMessages
import Helper4Swift

typealias JSONDictionary = [String: Any]

let postColorsArray = [
    UIColor(red: 252/255, green: 209/255, blue: 6/255, alpha: 1.0),  // THIS MAIN APP'S COLOR
    
    UIColor(red: 255.0/255.0, green: 207.0/255.0, blue: 85.0/255.0, alpha: 1.0),
    UIColor(red: 160.0/255.0, green: 212.0/255.0, blue: 104.0/255.0, alpha: 1.0),
    UIColor(red: 250.0/255.0, green: 110.0/255.0, blue: 82.0/255.0, alpha: 1.0),
    UIColor(red: 72.0/255.0, green: 207.0/255.0, blue: 174.0/255.0, alpha: 1.0),
    UIColor(red: 236.0/255.0, green: 136.0/255.0, blue: 192.0/255.0, alpha: 1.0),
    UIColor(red: 237.0/255.0, green: 85.0/255.0, blue: 100.0/255.0, alpha: 1.0),
    UIColor(red: 250.0/255.0, green: 110.0/255.0, blue: 82.0/255.0, alpha: 1.0),
    UIColor(red: 130.0/255.0, green: 202.0/255.0, blue: 156.0/255.0, alpha: 1.0),
]

// HUD View
let hudView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
let indicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
let APP_NAME = "Hajj"

extension MKPinAnnotationView {
    class func bluePinColor() -> UIColor {
        return UIColor.blue
    }
    class func mainPinColor() -> UIColor {
        return UIColor.mainColor
    }
    
}
extension UIColor {
    static var mainColor: UIColor {
        return UIColor(red:0.15, green:0.67, blue:0.53, alpha:1.0)
    }
    
    static var grayColor: UIColor {
        return UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
    }
}

extension UIViewController {
    func showHUD() {
        hudView.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        hudView.backgroundColor = postColorsArray[0]
        hudView.alpha = 0.9
        hudView.layer.cornerRadius = hudView.bounds.size.width/2
        hudView.layer.borderColor = UIColor.white.cgColor
        hudView.layer.borderWidth = 2
        
        indicatorView.center = CGPoint(x: hudView.frame.size.width/2, y: hudView.frame.size.height/2)
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        indicatorView.color = UIColor.white
        hudView.addSubview(indicatorView)
        indicatorView.startAnimating()
        view.addSubview(hudView)
    }
    
    func hideHUD() { hudView.removeFromSuperview() }
    
    func simpleAlert(_ mess: String) {
//        let alert = UIAlertView(title: APP_NAME, message: mess, delegate: nil, cancelButtonTitle: "OK")
//        alert.show()
        Helper4Swift.showBasicAlert(title: APP_NAME, message: mess, buttonTitle: "OK", vc: self)
    }
    
    typealias CompletionHandler = (_ success:Bool) -> Void
    
    func alert(_ mess: String){
        let messageView: MessageView = MessageView.viewFromNib(layout: .centeredView)
        messageView.configureBackgroundView(width: 250)
        messageView.configureContent(title: "Hajj", body: mess, iconImage: nil, iconText: "🕋", buttonImage: nil, buttonTitle: "حسناً") { _ in
            SwiftMessages.hide()
        }
        messageView.backgroundView.backgroundColor = UIColor.init(white: 0.97, alpha: 1)
        messageView.backgroundView.layer.cornerRadius = 10
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .center
        config.duration = .forever
        config.dimMode = .blur(style: .dark, alpha: 1, interactive: true)
        config.presentationContext  = .window(windowLevel: UIWindowLevelStatusBar)
        SwiftMessages.show(config: config, view: messageView)
    }
    
    func showError(_ mess: String) {
        let error = MessageView.viewFromNib(layout: .tabView)
        error.configureTheme(.error)
        error.configureContent(title: "", body: mess)
        error.button?.isHidden = true
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .top
        
        SwiftMessages.show(config: config, view: error)
        
    }
    
}

extension MKMapView {
    
    // delta is the zoom factor
    // 2 will zoom out x2
    // .5 will zoom in by x2
    
    func setZoomByDelta(delta: Double, animated: Bool) {
        var _region = region;
        var _span = region.span;
        _span.latitudeDelta *= delta;
        _span.longitudeDelta *= delta;
        _region.span = _span;
        
        setRegion(_region, animated: animated)
    }
}

