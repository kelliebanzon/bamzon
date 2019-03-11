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

    /*let fname = "Jake"
    let teamArray: NSArray = ["Cal Poly Swim Club", "Triathlon Team", "Men's Water Polo"]
    let locationArray: NSArray = ["Cal Poly, SLO", "Bishop Peak Tri", "Morro Bay HS"]
 */
    private var myTableView: UITableView!
    private let cellId = "MyTeamCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Team"
        print("selectTeam")
        self.showSpinner(onView: self.view)
        selectTeamVM.loadTableValues(parent: self)
        display()
    }
    
    func display() {
        // TODO: implement display
        view.backgroundColor = UIColor(named: "TSTeal")
        
        //create team button
        let createButton = createDefaultButton(withText: "Create a Team", withFrame: nil, withAction: #selector(createTeam), withCenter: nil)
        self.view.addSubview(createButton)
        
        //create team button constraints
        createButton.translatesAutoresizingMaskIntoConstraints = false
        let createLeftConstraint = createButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        let createTopConstraint = createButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60)
        let createRightConstraint = createButton.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -10)
        self.view.addConstraints([createLeftConstraint, createTopConstraint, createRightConstraint])
        
        //join team button
        let joinButton = createDefaultButton(withText: "Join a Team", withFrame: nil, withAction: #selector(joinTeam), withCenter: nil)
        self.view.addSubview(joinButton)
        
        //create team button constraints
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        let joinLeftConstraint = joinButton.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 10)
        let joinTopConstraint = joinButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60)
        let joinRightConstraint = self.view.trailingAnchor.constraint(equalTo: joinButton.trailingAnchor, constant: 20)
        self.view.addConstraints([joinLeftConstraint, joinTopConstraint, joinRightConstraint])
        
        //Teamsync label
        let teamsyncLabel = UILabel()
        teamsyncLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        teamsyncLabel.numberOfLines = 0
        teamsyncLabel.textColor = .white
        teamsyncLabel.textAlignment = .center
        teamsyncLabel.text = "TeamSync"
        self.view.addSubview(teamsyncLabel)
        
        //TeamSync label constraints
        teamsyncLabel.translatesAutoresizingMaskIntoConstraints = false
        let teamHorizConstraint = teamsyncLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let teamTopConstraint = teamsyncLabel.topAnchor.constraint(equalTo: joinButton.bottomAnchor, constant: 20)
        self.view.addConstraints([teamHorizConstraint, teamTopConstraint])
        
        //greeting label
        let greetLabel = UILabel()
        greetLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        greetLabel.numberOfLines = 0
        greetLabel.textColor = .white
        greetLabel.textAlignment = .center
        greetLabel.text = "Hey \(selectTeamVM.user.firstName), lookin' good today! Select a team to view more info"
        self.view.addSubview(greetLabel)
        
        //greet label constraints
        greetLabel.translatesAutoresizingMaskIntoConstraints = false
        let greetHorizConstraint = greetLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let greetVertConstraint = greetLabel.topAnchor.constraint(equalTo: teamsyncLabel.bottomAnchor, constant: 10)
        let greetLeftConstraint = greetLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40)
        let greetRightConstraint = self.view.trailingAnchor.constraint(equalTo: greetLabel.trailingAnchor, constant: 40)
        self.view.addConstraints([greetHorizConstraint, greetVertConstraint, greetLeftConstraint, greetRightConstraint])
        
        //select team table view
        myTableView = UITableView()
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyTeamCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(SelectTeamTableViewCell.self, forCellReuseIdentifier: self.cellId)
        myTableView.backgroundColor = UIColor(named: "TSTeal")
        self.view.addSubview(myTableView)
        
        //tableview constraints
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableHeightConstraint = myTableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        let tableTopConstraint = myTableView.topAnchor.constraint(equalTo: greetLabel.bottomAnchor, constant: 10)
        let tableLeftConstraint = myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let tableRightConstraint = view.trailingAnchor.constraint(equalTo: myTableView.trailingAnchor)
        self.view.addConstraints([tableHeightConstraint, tableTopConstraint, tableLeftConstraint, tableRightConstraint])
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
