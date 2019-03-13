//
//  CreateTeamChildNameVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/09/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class CreateTeamChildNameVC: UIViewController, UITableViewDataSource, UITableViewDelegate, DisplayableProtocol {
    
    let cellId = "cellId"
    var orgName: UITextField?
    var teamName: UITextField?
    var sportType: UITextField?

    var orgTableView: UITableView = UITableView()
    var orgList: [String] = ["University of Alabama", "University of California, Berkeley", "Cal Poly, SLO", "Stanford University"]
    
    var sportTableView: UITableView = UITableView()
    var sportList: [String] = ["Basketball", "Cross Country", "Golf", "Ice Hockey", "Lacrosse", "Swim", "Triathlon", "Water Polo"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create a Team"
        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")

        // Organization Label
        orgName = createDefaultTextField(withText: "Organization", withFrame: CGRect(x: 20, y: 240, width: 340, height: 35), withCenter: nil, withPadding: nil)
        self.view.addSubview(orgName!)
        
        orgName!.addTarget(self, action: #selector(selectOrg), for: UIControlEvents.allTouchEvents)
        
        orgName!.inputView = UIView() // Hide keyboard
        orgName!.tintColor = UIColor.clear
        
        // Team Name Label
        teamName = createDefaultTextField(withText: "Team Name", withFrame: CGRect(x: 20, y: 300, width: 340, height: 35), withCenter: nil, withPadding: nil)
        self.view.addSubview(teamName!)
        
        // Sport Type Label
        sportType = createDefaultTextField(withText: "Sport Type", withFrame: CGRect(x: 20, y: 355, width: 340, height: 35), withCenter: nil, withPadding: nil)
        self.view.addSubview(sportType!)
        
        sportType!.addTarget(self, action: #selector(selectTeam), for: UIControlEvents.allTouchEvents)
        
        sportType!.inputView = UIView() // Hide keyboard
        sportType!.tintColor = UIColor.clear
        
        // Next Button
        let button = createDefaultButton(withText: "Continue", withFrame: CGRect(x: 0, y: 0, width: 150, height: 50), withAction: #selector(checkFields), withCenter: CGPoint(x: view.center.x, y: 450))
        self.view.addSubview(button)

    }

    func setupAutoLayout() {
        // TODO: refactor display into this function
        let margins = view.safeAreaLayoutGuide
    }
    
    // Select Organization
    @objc func selectOrg(textField: UITextField) {
        orgTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        orgTableView.dataSource = self
        orgTableView.delegate = self
        let margins = view.safeAreaLayoutGuide
        orgTableView.frame = CGRect(x: 0, y: 0, width: margins.layoutFrame.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(orgTableView)
        orgTableView.reloadData()
    }
    
    @objc func selectTeam(textField: UITextField) {
        sportTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        sportTableView.dataSource = self
        sportTableView.delegate = self
        sportTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(sportTableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == orgTableView {
            return orgList.count
        } else if tableView == sportTableView {
            return sportList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if tableView == orgTableView {
            cell.textLabel?.text = orgList[indexPath.row]
        } else if tableView == sportTableView {
            cell.textLabel?.text = sportList[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == orgTableView {
            let org = orgList[indexPath.row]
            orgName!.text? = org
            orgTableView.removeFromSuperview()
        } else if tableView == sportTableView {
            let sport = sportList[indexPath.row]
            sportType!.text? = sport
            sportTableView.removeFromSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // General function to validate fields
    @objc func checkFields() {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateTeamChildLoadingVC")
        
        print("Valid Input:")
        print("\t  Org Name: " + (orgName!.text)!)
        print("\t Team Name: " + teamName!.text!)
        print("\t Sport Type: " + sportType!.text!)
        if let parentVC = self.parent as? CreateTeamParentVC {
            parentVC.createTeamVM.createTeam(teamName: teamName!.text!, orgName: orgName!.text!, sport: sportType!.text!)
        }
        self.navigationController!.pushViewController(nextVC, animated: true)
    }
}
