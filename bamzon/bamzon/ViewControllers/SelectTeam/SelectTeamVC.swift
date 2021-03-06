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
    private let refreshControl = UIRefreshControl()
    
    var createButton = UIButton()
    var joinButton = UIButton()
    var teamsyncLabel = UILabel()
    var teamsTableView = UITableView()

    let cellID = "MyTeamCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select a Team"
        let dispatch = DispatchGroup()
        teamsTableView.dataSource = self
        teamsTableView.delegate = self
        teamsTableView.register(SelectTeamTableViewCell.self, forCellReuseIdentifier: cellID)
        if #available(iOS 10.0, *) {
            teamsTableView.refreshControl = refreshControl
        } else {
            teamsTableView.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .white
        self.showSpinner(onView: self.view)
        selectTeamVM.loadTeams(dispatch: dispatch)
        dispatch.notify(queue: DispatchQueue.main) {
            self.removeSpinner()
            self.display()
        }
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        
        createButton = createDefaultButton(withText: "Create a Team", withFrame: nil, withAction: #selector(showCreateTeam), withCenter: nil)
        self.view.addSubview(createButton)
        
        joinButton = createDefaultButton(withText: "Join a Team", withFrame: nil, withAction: #selector(showJoinTeam), withCenter: nil)
        self.view.addSubview(joinButton)
        
        teamsyncLabel = createDefaultHeader1Label(text: "TeamSync", fontAlignment: .center)
        self.view.addSubview(teamsyncLabel)

        teamsTableView.backgroundColor = .clear
        teamsTableView.reloadData()
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
        let createTrailingConstraint = joinButton.leadingAnchor.constraint(equalTo: createButton.trailingAnchor, constant: 20)
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
        let dispatch = DispatchGroup()
        selectTeamVM.reloadUser(dispatch: dispatch)
        dispatch.notify(queue: DispatchQueue.main) {
            self.removeSpinner()
            self.display()
        }
    }
    
    @objc private func refresh(_ sender: Any) {
        refresh()
        self.refreshControl.endRefreshing()
    }
    
    @objc func showCreateTeam() {
        let createTeamVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateTeamChildNameVC")
        let createTeamNav = createDefaultNavigationController(rootViewController: createTeamVC)
        self.present(createTeamNav, animated: true, completion: nil)
    }
    
    @objc func showJoinTeam() {
        let joinTeamVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JoinTeamChildSelectTeamVC")
        let joinTeamNav = createDefaultNavigationController(rootViewController: joinTeamVC)
        self.present(joinTeamNav, animated: true, completion: nil)
    }
    
//    func viewTeam(team: Team) {
//        let dispatch = DispatchGroup()
//        selectTeamVM.selectTeam(team: team, dispatch: dispatch)
//    }
    
    func logout() {
    // TODO: implement logout
    }
    
    // Cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    // Display selected team and set root view to TabBarController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTeam = selectTeamVM.teams[indexPath.row]
        let dispatch = DispatchGroup()
        selectTeamVM.selectTeam(team: selectedTeam, dispatch: dispatch)
        dispatch.notify(queue: DispatchQueue.main) {
            self.teamsTableView.reloadData()
            self.setRootView(toVC: "TabBarController")
        }
    }

    // Number of sections to display
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of teams to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectTeamVM.teams.count
    }
    
    // Populate each cell with a team
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SelectTeamTableViewCell
        // swiftlint:enable force_cast
        cell.highlightYellowOnSelection()
        let team = selectTeamVM.teams[indexPath.row]
        let teamOrg = selectTeamVM.organizations[indexPath.row]
//        cell.imgUserName = team.
        cell.teamName.text = team.teamName
        cell.teamOrg.text = teamOrg.name
        return cell
    }
}
