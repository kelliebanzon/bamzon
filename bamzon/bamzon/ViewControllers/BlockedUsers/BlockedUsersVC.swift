//
//  BlockedUsersVC.swift
//  bamzon
//
//  Created by Kyle Vu on 3/17/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit

class BlockedUsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DisplayableProtocol {
    
    private let refreshControl = UIRefreshControl()
    //let blockedUsersVM = BlockedUsersVM()
    var blockedUsers = UITableView()
    let cellId = "requestCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Blocked Users"
        blockedUsers.dataSource = self
        blockedUsers.delegate = self
        blockedUsers.register(BlockedUsersTableViewCell.self, forCellReuseIdentifier: self.cellId)
        let dispatch = DispatchGroup()
        showSpinner(onView: self.view)
        
        if #available(iOS 10.0, *) {
            blockedUsers.refreshControl = refreshControl
        } else {
            blockedUsers.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .white
        
        //blockedUsersVM.loadRequests(dispatch: dispatch)
        dispatch.notify(queue: DispatchQueue.main) {
            self.removeSpinner()
            self.refresh()
        }
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        // Blocked Users label
        let blockedLabel = UILabel()
        blockedLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        blockedLabel.numberOfLines = 0
        blockedLabel.textColor = .white
        blockedLabel.textAlignment = .left
        blockedLabel.text = "Blocked Users"
        self.view.addSubview(blockedLabel)
        
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeBlockedUsers)), animated: true)
        
        //request label constraints
        blockedLabel.translatesAutoresizingMaskIntoConstraints = false
        let teamLeftConstraint = blockedLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)
        let teamTopConstraint = blockedLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50)
        self.view.addConstraints([teamLeftConstraint, teamTopConstraint])
        
        //select team table view
        blockedUsers.backgroundColor = UIColor(named: "TSTeal")
        blockedUsers.allowsSelection = false
        self.view.addSubview(blockedUsers)
        
        //tableview constraints
        blockedUsers.translatesAutoresizingMaskIntoConstraints = false
        let tableHeightConstraint = blockedUsers.heightAnchor.constraint(equalTo: view.heightAnchor)
        let tableTopConstraint = blockedUsers.topAnchor.constraint(equalTo: blockedLabel.bottomAnchor, constant: 10)
        let tableLeftConstraint = blockedUsers.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let tableRightConstraint = view.trailingAnchor.constraint(equalTo: blockedUsers.trailingAnchor)
        self.view.addConstraints([tableHeightConstraint, tableTopConstraint, tableLeftConstraint, tableRightConstraint])
    }
    
    @objc func closeBlockedUsers(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func refresh(_ sender: Any) {
        refresh()
        self.refreshControl.endRefreshing()
    }
    
    func refresh() {
        let dispatch = DispatchGroup()
        //blockedUsersVM.refresh(dispatch: dispatch)
        dispatch.notify(queue: DispatchQueue.main) {
            self.blockedUsers.reloadData()
            self.display()
        }
    }
    
    // Cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    // TODO: Return blocked users count from VM
    // Number of requests to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blockedUsersVM.reqUsers.count
    }
    
    // Populate each cell with a user and 3 buttons
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BlockedUsersTableViewCell
        // swiftlint:enable force_cast
        cell.teamName.text = blockedUsersVM.reqUsers[indexPath.row].getFullName()
        cell.unblockButton.addTarget(self, action: #selector(unblockUser), for: .touchUpInside)
        return cell
    }
    
    // Approve the request by identifying the user with the .tag attribute
    @objc func unblockUser(sender: UIButton) {
        //        blockedUsersVM.unblockUser(reqIndex: sender.tag)
        refresh()
    }
}
