//
//  SettingsVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DisplayableProtocol {

    let settingsVM = SettingsVM()
    let cellId = "cellId"
    
    var settingsTableView: UITableView = UITableView()
    var settingsList: [String] = ["Switch Teams", "Team Settings", "Join Requests", "Blocked Users"]
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
    
    // Number of sections to display
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    // Number of settings to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return settingsList.count
        } else if section == 1 {
            return logOut.count
        } else {
            return 0
        }
    }
    
    // Populate each cell with a setting
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor(named: "TSTeal")
        cell.highlightYellowOnSelection()
        if indexPath.section == 0 {
            cell.textLabel?.text = settingsList[indexPath.row]
            cell.textLabel?.textColor = .white
        } else if indexPath.section == 1 {
            cell.textLabel?.text = logOut[indexPath.row]
            cell.textLabel?.textColor = UIColor(named: "TSOrange")
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
            cell.textLabel?.textAlignment = .center
        }
        return cell
    }
    
    // Function to handle what setting to call
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == 0 {
            if settingsList[indexPath.row] == "Switch Teams" {
                setRootView(toVC: "SelectTeamVC")
            } else if settingsList[indexPath.row] == "Team Settings" {
                alert(withTitle: "⚠️ Not Implemented ⚠️", withMessage: "Team Settings has not been implemeted yet.")
            } else if settingsList[indexPath.row] == "Join Requests" {
                showJoinRequests()
            } else if settingsList[indexPath.row] == "Blocked Users" {
                showBlockedUsers()
            } else {
                alert(withTitle: "Uh oh 😰", withMessage: "This isn't supposed to happen! Section 0")
            }
        } else if indexPath.section == 1 {
            let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
            // Sets root view controller back to LoginVC
            alert.addAction(UIAlertAction(title: "Log Out", style: .default, handler: {(_: UIAlertAction!) in
                self.settingsVM.logout()
                self.setRootView(toVC: "LoginVC")
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(_: UIAlertAction!) in print("Do cancel logic here")
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            alert(withTitle: "Uh oh 😰", withMessage: "This isn't supposed to happen! Section 1")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Cell height
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
        let closeTop = closeButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: offsets["horizEdges"]!)
        let closeTrailing = closeButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30)
        let closeHeight = closeButton.heightAnchor.constraint(equalToConstant: 24)
        let closeAspect = closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor)
        self.view.addConstraints([closeTop, closeTrailing, closeHeight, closeAspect])
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        let topLabelHorizontalConstraint = topLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor)
        let topLabelVerticalConstraint = topLabel.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor)
//        let topLabelTopConstraint = topLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: offsets["horizEdges"]!)
        self.view.addConstraints([topLabelVerticalConstraint, topLabelHorizontalConstraint])
        
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableTop = settingsTableView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 20)
        let tableLeading = settingsTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let tableTrailing = settingsTableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        let tableBottom = settingsTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        self.view.addConstraints([tableTop, tableLeading, tableTrailing, tableBottom])
    }

    func showJoinRequests() {
        let joinRequestsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JoinRequestsVC")
        let joinRequestsNav = createDefaultNavigationController(rootViewController: joinRequestsVC)
        self.present(joinRequestsNav, animated: true, completion: nil)
    }
    
    func showBlockedUsers() {
        let blockedUsersVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BlockedUsersVC")
        let blockedUsersNav = createDefaultNavigationController(rootViewController: blockedUsersVC)
        self.present(blockedUsersNav, animated: true, completion: nil)
    }
    
    func selectUser() {
        // TODO: implement selectUser
    }
}
