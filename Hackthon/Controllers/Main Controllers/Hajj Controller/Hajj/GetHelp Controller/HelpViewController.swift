//
//  HelpViewController.swift
//  HajjHackathonIOS
//
//  Created by Abdullah Alhaider on 02/08/2018.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit
import Helper4Swift


class HelpViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let cellID = "HelpCell"
    fileprivate let helpArray = ["استشارة طبية","الامن","الاسعاف","الدفاع المدني"]
    fileprivate let helpNumbers = ["937","911","997","998"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    fileprivate func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 30
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss()
    }
    
    
    fileprivate func dismiss(){
        dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showBackgroundView"), object: nil)
        }
    }
    
    
}
extension HelpViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let phoneNumber = helpNumbers[indexPath.row]
        Helper4Swift.shakePhone(style: .medium)
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

extension HelpViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? HelpTableViewCell else { return UITableViewCell()}
        cell.titleLabel.text = helpArray[indexPath.row]
        return cell
    }
}
