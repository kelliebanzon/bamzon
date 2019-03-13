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
    var settingsList: [String] = ["Team Settings", "Join Requests"]
    var logOut: [String] = ["Log Out"]
    var sections: [String] = ["Settings", "Log Out"]
    var topLabel = UILabel()

    var closeButton = UIButton()
    
    let offsets: [String: CGFloat] = [
        "vertEdges": 40,
        "horizEdges": 20,
        "inTableSpacing": 12
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")

        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")

        closeButton = createCloseButton(action: #selector(closeSettings))
        self.view.addSubview(closeButton)
        
        topLabel = createDefaultHeader1Label(text: "Settings", numLines: 1)
        self.view.addSubview(topLabel)
        
        settingsTableView.backgroundColor = UIColor(named: "TSTeal")
        settingsTableView.tableFooterView = UIView(frame: .zero)
        self.view.addSubview(settingsTableView)
        
        setupAutoLayout()
    }

    @objc func closeSettings(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Setting number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    // Number of rows to present
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return settingsList.count
        } else if section == 1 {
            return logOut.count
        } else {
            return 0
        }
    }
    
    // Populate value at selected row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = settingsList[indexPath.row]
            cell.textLabel?.textColor = .white
        } else if indexPath.section == 1 {
            cell.textLabel?.text = logOut[indexPath.row]
            cell.textLabel?.textColor = UIColor(named: "TSOrange")
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
            cell.textLabel?.textAlignment = .center
        }
        cell.backgroundColor = UIColor(named: "TSTeal")
        return cell
    }
    
    // Function to handle what setting to call
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if settingsList[indexPath.row] == "Team Settings" {
                alert(withTitle: "Do something here", withMessage: "Something is supposed to happen")
            } else if settingsList[indexPath.row] == "Join Requests" {
                alert(withTitle: "⚠️ Go to JoinRequestVC ⚠️", withMessage: "Make shit happen here")
            } else {
                alert(withTitle: "Uh oh 😰", withMessage: "This isn't supposed to happen!")
            }
        } else if indexPath.section == 1 {
            let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
            // Sets root view controller back to LoginVC
            alert.addAction(UIAlertAction(title: "Log Out", style: .default, handler: {(_: UIAlertAction!) in self.setRootView(toVC: "LoginVC")
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(_: UIAlertAction!) in print("Do cancel logic here")
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            alert(withTitle: "Uh oh 😰", withMessage: "This isn't supposed to happen!")
        }
        print("YEET BABY! We've got a selection for " + settingsList[indexPath.row])
    }
    
    // Set the height of each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50
        switch indexPath.section {
        case 0:
            return 50
        default:
            return 75
        }
    }
    
    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        let closeTop = closeButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20)
        let closeTrailing = closeButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20)
        let closeHeight = closeButton.heightAnchor.constraint(equalToConstant: 24)
        let closeAspect = closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor)
        self.view.addConstraints([closeTop, closeTrailing, closeHeight, closeAspect])
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        let topLabelHorizontalConstraint = topLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor)
        let topLabelTopConstraint = topLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: offsets["horizEdges"]!)
        self.view.addConstraints([topLabelTopConstraint, topLabelHorizontalConstraint])
        
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableTop = settingsTableView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20)
        let tableLeading = settingsTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let tableTrailing = settingsTableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        let tableBottom = settingsTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        self.view.addConstraints([tableTop, tableLeading, tableTrailing, tableBottom])
    }
    
    func selectUser() {
        // TODO: implement selectUser
    }
    
    func viewJoinRequests() {
        // TODO: implement view join requests
    }
}
