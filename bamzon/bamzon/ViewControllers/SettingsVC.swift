//
//  SettingsVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DisplayableProtocol {
    
    let cellId = "cellId"
    
    var settingsTableView: UITableView = UITableView()
    var settingsList: [String] = ["Team Settings", "Log Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        
        let topLabel = pageLabel(withText: "Settings", withFrame: nil, withCenter: nil)
        self.view.addSubview(topLabel)
        
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        settingsTableView.frame = CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        settingsTableView.backgroundColor = UIColor(named: "TSTeal")
        settingsTableView.tableFooterView = UIView(frame: .zero)
        self.view.addSubview(settingsTableView)
        /*//tableview constraints
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableHeightConstraint = settingsTableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        let tableTopConstraint = settingsTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 32.0)
        let tableLeftConstraint = settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let tableRightConstraint = view.trailingAnchor.constraint(equalTo: settingsTableView.trailingAnchor)
        self.view.addConstraints([tableHeightConstraint, tableTopConstraint, tableLeftConstraint, tableRightConstraint])*/
        
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        
        //settingsTableView.backgroundColor = UIColor(named: "TSTeal")
    }
    
    // Setting number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows to present
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsList.count
    }
    
    // Populate value at selected row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = settingsList[indexPath.row]
        if (settingsList[indexPath.row] == "Log Out") {
            cell.textLabel?.textColor = UIColor(named: "TSOrange")
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        } else {
            cell.textLabel?.textColor = .white
        }
        cell.backgroundColor = UIColor(named: "TSTeal")
        return cell
    }
    
    // Function to handle what setting to call
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (settingsList[indexPath.row] == "Log Out") {
            let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Log Out", style: .default, handler: {
                (action: UIAlertAction!) in
                let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")
                // swiftlint:disable force_cast
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                // swiftlint:enable force_cast
                appDelegate.hideTabController()
                appDelegate.window?.rootViewController = nextVC
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction!) in print("Do cancel logic here")
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            alert(withTitle: "Do something here", withMessage: "Something is supposed to happen")
        }
        print("YEET BABY! We've got a selection for " + settingsList[indexPath.row])
    }
    
    // Set the height of each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func selectUser() {
        // TODO: implement selectUser
    }
    
    func viewJoinRequests() {
        // TODO: implement view join requests
    }
}
