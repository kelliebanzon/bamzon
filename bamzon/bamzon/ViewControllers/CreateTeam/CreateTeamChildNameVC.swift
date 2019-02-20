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
    
    var orgTableView: UITableView = UITableView()
    var orgList: [String] = ["University of Alabama", "University of California, Berkely", "Cal Poly, SLO", "Stanford University"]
    
    var sportTableView: UITableView = UITableView()
    var sportList: [String] = ["Basketball", "Cross Country", "Golf", "Ice Hockey", "Lacrosse", "Swim", "Triathlon", "Water Polo"]

    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }
    
    func display() {
        // TODO: implement display
        view.backgroundColor = UIColor(named: "TSTeal")
        
        // Top Label
        let topLabel = pageLabel(withText: "Create a Team", withFrame: nil, withCenter: nil)
        self.view.addSubview(topLabel)
        
        // Organization Label
        let orgName = createDefaultTextField(withText: "Organization", withFrame: CGRect(x: 20, y: 240, width: 340, height: 35), withCenter: nil, withPadding: nil)
        self.view.addSubview(orgName)
        
        orgName.addTarget(self, action: #selector(selectOrg), for: UIControlEvents.allTouchEvents)
        
        // Team Name Label
        let teamName = createDefaultTextField(withText: "Team Name", withFrame: CGRect(x: 20, y: 300, width: 340, height: 35), withCenter: nil, withPadding: nil)
        self.view.addSubview(teamName)
        
        // Sport Type Label
        let sportType = createDefaultTextField(withText: "Sport Type", withFrame: CGRect(x: 20, y: 355, width: 340, height: 35), withCenter: nil, withPadding: nil)
        self.view.addSubview(sportType)
        
        // Next Button
        let button = createDefaultButton(withText: "Continue", withFrame: CGRect(x: 0, y: 0, width: 150, height: 50), withAction: #selector(checkFields), withCenter: CGPoint(x: view.center.x, y: 450))
        self.view.addSubview(button)
    }
    
    @objc func selectOrg(textField: UITextField) {
        orgTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        orgTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(orgTableView)
        orgTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orgList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = orgList[indexPath.row]
        print("Fuck")
        return cell
    }
    
    func promptTeamName() {
        // TODO: implement prompt team name
    }
    
    func promptOrganization() {
        // TODO: implement prompt organization
    }
    
    func promptSport() {
        // TODO: implement prompt sport
    }
    
    // General function to validate fields
    @objc func checkFields() {
        let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "CreateTeamChildSettingsVC") as? CreateTeamChildSettingsVC
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
