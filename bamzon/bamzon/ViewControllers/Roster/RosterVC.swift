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
    
    //TODO: should be passed after initialization.
    // not sure if it should be forced on initialization or passed
    var team: Team?
    var rosterVM = RosterVM()
    var members = [User]()
    
    private var myTableView: UITableView!
    private let cellId = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Roster"
        if team != nil {
            rosterVM.refresh(rosterVC: self, teamID: team!.teamID)
        }
        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        
        myTableView = UITableView()
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(RosterTableViewCell.self, forCellReuseIdentifier: self.cellId)
        myTableView.backgroundColor = UIColor(named: "TSTeal")
        self.view.addSubview(myTableView)
        
        //tableview constraints
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableHeightConstraint = myTableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        let tableTopConstraint = myTableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let tableLeftConstraint = myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let tableRightConstraint = view.trailingAnchor.constraint(equalTo: myTableView.trailingAnchor)
        self.view.addConstraints([tableHeightConstraint, tableTopConstraint, tableLeftConstraint, tableRightConstraint])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectUser()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RosterTableViewCell
        // swiftlint:enable force_cast
        let member = members[indexPath.row]
        cell.userName.text = member.firstName + " " + member.lastName
        
        cell.imgUser.image = UIImage(named: member.imageURL ?? ImageUtility().defaultProfilePictureName)
        
        cell.userNumber.text = member.phone
        cell.userEmail.text = member.email
        if let year = member.schoolYear {
            cell.userYear.text = "\(year.rawValue)"
        } else {
            cell.userYear.text = "-"
        }
        return cell
    }
    
    func edit() {
        // TODO: implement edit
    }
    
    func refresh() {
        if team != nil {
            rosterVM.refresh(rosterVC: self, teamID: team!.teamID)
        }
    }
    
    func selectUser() {
        // TODO: implement selectUser
    }
    
    func sortBy(filter: String) {
        // TODO: implement sort by
    }
    
}
