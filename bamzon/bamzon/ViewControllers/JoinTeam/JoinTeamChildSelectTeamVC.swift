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
    var orgName: UITextField?
    var teamName: UITextField?
    
    var orgTableView: UITableView = UITableView()
    var orgList: [String] = ["University of Alabama", "University of California, Berkely", "Cal Poly, SLO", "Stanford University"]
    
    // teamList needs to be populated - determined by which org is selected.
    // all teamList references must be generalized using the orgName (some sort of struct
    // that holds a shorthand org name that can be used to append to a lookup string that
    // will be used for selectTeam func.
    var teamTableView: UITableView = UITableView()
    var teamList: [String] = ["Distance Club", "Folding Club", "Happy Club", "Jam Team", "Mechanics Club", "Oof Team", "Pie Club", "Swim Club", "Triathlon Team"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }
    
    func display() {
        // TODO: implement display
        view.backgroundColor = UIColor(named: "TSTeal")
        
        // Top Label
        let topLabel = pageLabel(withText: "Join a Team", withFrame: nil, withCenter: nil)
        self.view.addSubview(topLabel)
        
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
            return orgList.count
        } else if tableView == teamTableView {
            return teamList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if tableView == orgTableView {
            cell.textLabel?.text = orgList[indexPath.row]
        } else if tableView == teamTableView {
            cell.textLabel?.text = teamList[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == orgTableView {
            let org = orgList[indexPath.row]
            orgName!.text? = org
            orgTableView.removeFromSuperview()
        } else if tableView == teamTableView {
            let team = teamList[indexPath.row]
            teamName!.text? = team
            teamTableView.removeFromSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // General function to validate fields
    @objc func checkFields() {
        let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "JoinTeamChildRequestSentVC") as? JoinTeamChildRequestSentVC
        
        print("Valid Input:")
        print("\t  Org Name: " + (orgName!.text)!)
        print("\t Team Name: " + teamName!.text!)
        if let parentVC = self.parent as? JoinTeamParentVC {
            parentVC.joinTeamVM.sendJoinRequest(org: orgName!.text!, team: teamName!.text!)
        }
        
        self.mockSegue(toVC: nextVC!)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
