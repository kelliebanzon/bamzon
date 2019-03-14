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
    var selectedOrg: Organization?
    var createTeamVM = CreateTeamVM()

    var orgTableView: UITableView = UITableView()
    
    var sportTableView: UITableView = UITableView()
    var sportList: [String] = ["Basketball", "Cross Country", "Golf", "Ice Hockey", "Lacrosse", "Swim", "Triathlon", "Water Polo", "Distance Running"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create a Team"
        let dispatch = DispatchGroup()
        createTeamVM.loadOrgs(dispatch: dispatch)
        dispatch.notify(queue: DispatchQueue.main) {
            self.display()
        }
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")

        navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeCreateTeam)), animated: true)

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
        let button = createDefaultButton(withText: "Continue", withFrame: CGRect(x: 0, y: 0, width: 150, height: 50), withAction: #selector(tryCreateTeam), withCenter: CGPoint(x: view.center.x, y: 450))
        self.view.addSubview(button)

    }

    func setupAutoLayout() {
        // TODO: refactor display into this function
        let margins = view.safeAreaLayoutGuide
    }

    @objc func closeCreateTeam(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
            return self.createTeamVM.allOrgs.count
        } else if tableView == sportTableView {
            return sportList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if tableView == orgTableView {
            cell.textLabel?.text = createTeamVM.allOrgs[indexPath.row].name
        } else if tableView == sportTableView {
            cell.textLabel?.text = sportList[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.contentView.backgroundColor = UIColor(named: "TSYellow")
        if tableView == orgTableView {
            selectedOrg = createTeamVM.allOrgs[indexPath.row]
            orgName!.text? = selectedOrg!.name
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
    
    @objc func tryCreateTeam() {
        if checkValidFields() {
            let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateTeamChildLoadingVC")
            self.createTeamVM.createTeam(teamName: teamName!.text!, org: selectedOrg!, sport: sportType!.text!)
            self.navigationController!.pushViewController(nextVC, animated: true)
        } else {
            missingFieldsAlert()
        }
    }
    
    func missingFieldsAlert() {
        let alert = UIAlertController(title: "Missing Fields", message: "Team name, organization, and sport are requried.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        let fillTeamName = teamName?.text ?? "Team Name"
        let fillOrg = orgName?.text ?? "Organization"
        let fillSport = sportType?.text ?? "Sport Type"

        teamName?.attributedPlaceholder = NSAttributedString(string: fillTeamName , attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSOrange")!])
        orgName?.attributedPlaceholder = NSAttributedString(string: fillOrg, attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSOrange")!])
        sportType?.attributedPlaceholder = NSAttributedString(string: fillSport, attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSOrange")!])
    }
    
    func checkValidFields() -> Bool {
        return !(orgName?.text?.isEmpty)! || !(teamName?.text?.isEmpty)!  || !(sportType?.text?.isEmpty)!
    }
}
