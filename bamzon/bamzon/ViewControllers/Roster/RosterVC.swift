//
//  RosterVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class RosterVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DisplayableProtocol, EditableProtocol, RefreshableProtocol {
    
    private let refreshControl = UIRefreshControl()
    
    //TODO: should be passed after initialization.
    // not sure if it should be forced on initialization or passed
    var rosterVM = RosterVM()
    
    private var myTableView = UITableView()
    private let cellId = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Roster"
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(RosterTableViewCell.self, forCellReuseIdentifier: self.cellId)
        if #available(iOS 10.0, *) {
            myTableView.refreshControl = refreshControl
        } else {
            myTableView.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .white
        
        let dispatch = DispatchGroup()
        rosterVM.refresh(dispatch: dispatch)
        dispatch.notify(queue: DispatchQueue.main) {
            self.display()
        }
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        
        myTableView.backgroundColor = .clear
        self.view.addSubview(myTableView)
        
        setupAutoLayout()
    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        myTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableHeightConstraint = myTableView.heightAnchor.constraint(equalTo: margins.heightAnchor)
        let tableTopConstraint = myTableView.topAnchor.constraint(equalTo: margins.topAnchor)
        let tableLeftConstraint = myTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let tableRightConstraint = margins.trailingAnchor.constraint(equalTo: myTableView.trailingAnchor)
        self.view.addConstraints([tableHeightConstraint, tableTopConstraint, tableLeftConstraint, tableRightConstraint])
    }
    
    // Cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // Display a specific users' profile from the roster
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = rosterVM.members[indexPath.row]
        // swiftlint:disable force_cast
        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        // swiftlint:enable force_cast
        profileVC.selectedUser = selectedUser
        self.navigationController?.pushViewController(profileVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Number of members to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rosterVM.members.count
    }
    
    // Populate each cell with a player
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RosterTableViewCell
        // swiftlint:enable force_cast
        cell.highlightYellowOnSelection()
        let member = rosterVM.members[indexPath.row]
        cell.userName.text = member.firstName + " " + member.lastName
        cell.imgUserName = member.imageURL
        cell.userNumber.text = member.phone
        cell.userEmail.text = member.email
        if let year = member.schoolYear, year.rawValue != 0 {
            cell.userYear.text = "\(year.rawValue)"
        } else {
            cell.userYear.text = "-"
        }
        return cell
    }
    
    func edit() {
        // TODO: implement edit
    }
    
    @objc private func refresh(_ sender: Any) {
        refresh()
        self.refreshControl.endRefreshing()
    }
    
    func refresh() {
        let dispatch = DispatchGroup()
        rosterVM.refresh(dispatch: dispatch)
        dispatch.notify(queue: DispatchQueue.main) {
            self.display()
        }
    }
    
    func selectUser() {
        // TODO: implement selectUser
    }
    
    func sortBy(filter: String) {
        // TODO: implement sort by
    }
    
}
