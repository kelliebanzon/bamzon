//
//  JoinTeamChildSelectTeamVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/21/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit

class JoinTeamChildSelectTeamVC: UIViewController, UITableViewDataSource, UITableViewDelegate, DisplayableProtocol {
    
    let cellId = "cellId"
    var backButton = UIButton()
    var orgName: UITextField?
    var selectedOrg: Organization?
    var teamName: UITextField?
    var selectedTeam: Team?
    var selectedTeamIndex: Int?
    var joinTeamVM = JoinTeamVM()
    let dispatch = DispatchGroup()
    
    var orgTableView: UITableView = UITableView()
    var teamTableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Join a Team"
        joinTeamVM.loadOrgs(dispatch: dispatch)
        dispatch.notify(queue: DispatchQueue.main) {
            self.display()
        }
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        
        // Organization Label
        orgName = createDefaultTextField(withText: "Organization", withFrame: CGRect(x: 20, y: 240, width: 340, height: 35), withCenter: nil, withPadding: nil)
        self.view.addSubview(orgName!)
        
        orgName!.addTarget(self, action: #selector(selectOrg), for: UIControlEvents.allTouchEvents)
        
        orgName!.inputView = UIView() // Hide keyboard
        orgName!.tintColor = UIColor.clear
        
        // Team Label
        teamName = createDefaultTextField(withText: "Team Name", withFrame: CGRect(x: 20, y: 300, width: 340, height: 35), withCenter: nil, withPadding: nil)
        self.view.addSubview(teamName!)
        
        teamName!.addTarget(self, action: #selector(selectTeam), for: UIControlEvents.allTouchEvents)
        
        teamName!.inputView = UIView() // Hide keyboard
        teamName!.tintColor = UIColor.clear
        
        // Next Button
        let button = createDefaultButton(withText: "Continue", withFrame: CGRect(x: 0, y: 0, width: 150, height: 50), withAction: #selector(checkFields), withCenter: CGPoint(x: view.center.x, y: 450))
        self.view.addSubview(button)
    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide
        
    }

    @objc func selectOrg(textField: UITextField) {
        teamName?.text = ""
        orgTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        orgTableView.dataSource = self
        orgTableView.delegate = self
        orgTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(orgTableView)
    }
    
    @objc func selectTeam(textField: UITextField) {
        if !(orgName?.text?.isEmpty)! {
            teamTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            teamTableView.dataSource = self
            teamTableView.delegate = self
            teamTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.view.addSubview(teamTableView)
        } else {
            alert(withTitle: "⚠️ No Org. Selected ⚠️", withMessage: "Please select an organization before selecting a team.")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == orgTableView {
            return self.joinTeamVM.allOrgs.count
        } else if tableView == teamTableView {
            return self.joinTeamVM.teams.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if tableView == orgTableView {
            self.selectedOrg = self.joinTeamVM.allOrgs[indexPath.row]
            cell.textLabel?.text = self.selectedOrg!.name
        } else if tableView == teamTableView {
            cell.textLabel?.text = joinTeamVM.teams[indexPath.row].teamName
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == orgTableView {
            let org = self.joinTeamVM.allOrgs[indexPath.row]
            orgName!.text? = self.joinTeamVM.allOrgs[indexPath.row].name
            self.joinTeamVM.loadTeamsWithOrg(dispatch: dispatch, org: org)
            orgTableView.removeFromSuperview()
        } else if tableView == teamTableView {
            let team = joinTeamVM.teams[indexPath.row].teamName
            teamName!.text? = team
            teamTableView.removeFromSuperview()
            self.selectedTeamIndex = indexPath.row
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // General function to validate fields
    @objc func checkFields() {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JoinTeamChildRequestSentVC")
        
        print("Valid Input:")
        print("\t  Org Name: " + (orgName!.text)!)
        print("\t Team Name: " + teamName!.text!)
        if let selectedTeamIndex = selectedTeamIndex {
            self.joinTeamVM.sendJoinRequest(teamIndex: selectedTeamIndex)
            self.navigationController!.pushViewController(nextVC, animated: true)
        } else {
            return
        }

    }
}
