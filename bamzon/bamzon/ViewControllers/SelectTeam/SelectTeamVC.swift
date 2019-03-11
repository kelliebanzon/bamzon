//
//  SelectTeamVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class SelectTeamVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DisplayableProtocol, RefreshableProtocol {
    
    let selectTeamVM = SelectTeamVM()

    var createButton = UIButton()
    var joinButton = UIButton()
    var teamsyncLabel = UILabel()
    var teamsTableView = UITableView()

    let cellID = "MyTeamCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Team"
        print("selectTeam")
        self.showSpinner(onView: self.view)
        selectTeamVM.loadTableValues(parent: self, teamVC: self)
        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        
        createButton = createDefaultButton(withText: "Create a Team", withFrame: nil, withAction: #selector(createTeam), withCenter: nil)
        self.view.addSubview(createButton)
        
        joinButton = createDefaultButton(withText: "Join a Team", withFrame: nil, withAction: #selector(joinTeam), withCenter: nil)
        self.view.addSubview(joinButton)
        
        teamsyncLabel = createDefaultHeader1Label(text: "TeamSync")
        teamsyncLabel.textAlignment = .center
        self.view.addSubview(teamsyncLabel)
        
        teamsTableView.dataSource = self
        teamsTableView.delegate = self
        teamsTableView.register(SelectTeamTableViewCell.self, forCellReuseIdentifier: cellID)
        teamsTableView.backgroundColor = UIColor(named: "TSTeal")
        self.view.addSubview(teamsTableView)
        
        setupAutoLayout()
    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        teamsyncLabel.translatesAutoresizingMaskIntoConstraints = false
        let teamHorizConstraint = teamsyncLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor)
        let teamTopConstraint = teamsyncLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20)
        self.view.addConstraints([teamHorizConstraint, teamTopConstraint])

        createButton.translatesAutoresizingMaskIntoConstraints = false
        let createLeftConstraint = createButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20)
        let createTopConstraint = createButton.topAnchor.constraint(equalTo: teamsyncLabel.bottomAnchor, constant: 20)
        let createTrailingConstraint = joinButton.leadingAnchor.constraint(equalTo: createButton.trailingAnchor, constant: 20)//createButton.trailingAnchor.constraint(greaterThanOrEqualTo: joinButton.leadingAnchor, constant: 20)
        self.view.addConstraints([createLeftConstraint, createTopConstraint, createTrailingConstraint])

        joinButton.translatesAutoresizingMaskIntoConstraints = false
        let joinTopConstraint = joinButton.topAnchor.constraint(equalTo: createButton.topAnchor)
        let joinTrailingConstraint = margins.trailingAnchor.constraint(equalTo: joinButton.trailingAnchor, constant: 20)
        let joinBottomConstraint = joinButton.bottomAnchor.constraint(equalTo: createButton.bottomAnchor)
        let joinWidthConstraint = joinButton.widthAnchor.constraint(equalTo: createButton.widthAnchor)
        self.view.addConstraints([joinTopConstraint, joinTrailingConstraint, joinBottomConstraint, joinWidthConstraint])

        teamsTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableTopConstraint = teamsTableView.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: 20)
        let tableLeadingConstraint = teamsTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let tableTrailingConstraint = margins.trailingAnchor.constraint(equalTo: teamsTableView.trailingAnchor)
        let tableBottomConstraint = margins.bottomAnchor.constraint(equalTo: teamsTableView.bottomAnchor)
        self.view.addConstraints([tableTopConstraint, tableLeadingConstraint, tableTrailingConstraint, tableBottomConstraint])
    }
    
    func refresh() {
        // TODO: implement refresh
    }
    
    @objc func createTeam() {
    // TODO: implement create team
    }
    
    @objc func joinTeam() {
    // TODO: implement join team
    }
    
    func viewTeam(team: Team) {
        selectTeamVM.selectTeam(team: team)
    }
    
    func logout() {
    // TODO: implement logout
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(selectTeamVM.teams[indexPath.row])")
        //viewTeam()
        //TODO: Find a way to access cell elements here? So we can set each cell label to be what's in the array by using indexpath
        //            // swiftlint:disable force_cast
        //            let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //            // swiftlint:enable force_cast
        //            appDelegate.showTabController()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectTeamVM.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SelectTeamTableViewCell
        let team = selectTeamVM.teams[indexPath.row]
        // swiftlint:enable force_cast
        cell.teamName.text = team.teamName
//        cell.teamLocation.text = team.
        return cell
    }
}
