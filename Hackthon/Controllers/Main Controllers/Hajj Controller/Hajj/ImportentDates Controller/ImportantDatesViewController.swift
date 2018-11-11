//
//  ImportantDatesViewController.swift
//  HajjHackathonIOS
//
//  Created by Abdullah Alhaider on 01/08/2018.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit
import Helper4Swift
import UserNotifications


class ImportantDatesViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var arrowButton: UIButton!
    
    
    fileprivate let cellID = "ImportantDatesCell"
    //fileprivate let url = "https://flextubeapp.com/getdates"
    fileprivate let url = "https://api.myjson.com/bins/14zlxs"
    fileprivate var days: [String] = []
    fileprivate var dates: [String] = []
    fileprivate var descriptionText: [String] = []
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        view.addSubview(indicator)
        indicator.activityIndicatorViewStyle = .gray
        indicator.center = view.center
        return indicator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetch()
    }

    @IBAction func dismissPresed(_ sender: UIButton) {
        dismiss()
    }
    
    @IBAction func arrowDownPresed(_ sender: UIButton) {
        dismiss()
    }
    
    fileprivate func dismiss(){
        dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showBackgroundView"), object: nil)
        }
    }
    
    fileprivate func setup(){
        arrowButton.setImage(UIImage(named: "arrow_down"), for: .normal)
        arrowButton.imageView?.contentMode = .scaleAspectFit
        
        tableView.delegate = self
        tableView.dataSource = self
        backView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        backView.layer.cornerRadius = 30
    }
    
    fileprivate func fetch() {
        indicator.startAnimating()
        Helper4Swift.fetchGenericData(urlString: url) { (dates: [Dates]) in
            dates.forEach({self.days.append($0.day!)})
            dates.forEach({self.dates.append($0.date!)})
            dates.forEach({self.descriptionText.append($0.description!)})
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
            }
        }
    }
    
    
}

extension ImportantDatesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }

    
}

extension ImportantDatesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ImportantDatesTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = days[indexPath.row]
        cell.subtitleLabel.text = dates[indexPath.row]
        cell.descriptionLabel.text = descriptionText[indexPath.row]
        return cell
    }
}
