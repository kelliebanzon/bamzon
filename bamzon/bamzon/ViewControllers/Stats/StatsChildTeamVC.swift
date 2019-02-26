//
//  StatsChildTeamVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/07/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class StatsChildTeamVC: UIViewController, UITableViewDelegate, UITableViewDataSource, IndicatorInfoProvider, DisplayableProtocol {
    
    //this is very hardcoded but I had unexpected project in other class
    
    let team = "Cal Poly Swim Club"

    let statTypes = ["Total Meets:", "Combined Score First Places:", "Women's Team First Places:", "Men's Team First Places:"]
    
    let stats = [603, 370, 220, 150]
    
    var teamLabel = UILabel()
    
    private var myTableView: UITableView!
    private let cellId = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }
    
    func display() {
        // TODO: display
        view.backgroundColor = UIColor(named: "TSOrange")
        
        //Team label
        teamLabel = createDefaultLabel(text: team, fontSize: 30, numLines: 1, fontColor: .white, fontAlignment: .center)
        
        myTableView = UITableView()
        //myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(StatsTeamStatsViewCell.self, forCellReuseIdentifier: self.cellId)
        myTableView.backgroundColor = UIColor(named: "TSTeal")
        
        addSubviews()
        setupAutoLayout()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! StatsTeamStatsViewCell
        // swiftlint:enable force_cast
        let statType = statTypes[indexPath.row]
        let stat = stats[indexPath.row]
        
        cell.statsDescLabel.text = statType
        cell.statsLabel.text = "\(stat)"
        
        return cell
    }
    
     // MARK: - Navigation
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Team Stats")
    }

    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func addSubviews() {
        self.view.addSubview(teamLabel)
        self.view.addSubview(myTableView)
    }
    
    func setupAutoLayout() {
        //team label constraints
        let nameHorizConstraint = teamLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let nameTopConstraint = teamLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50)
        self.view.addConstraints([nameHorizConstraint, nameTopConstraint])
        
        //tableview constraints
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        let tableHeightConstraint = myTableView.heightAnchor.constraint(equalToConstant: 200)
        let tableTopConstraint = myTableView.topAnchor.constraint(equalTo: teamLabel.bottomAnchor, constant: 20)
        let tableLeftConstraint = myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let tableRightConstraint = view.trailingAnchor.constraint(equalTo: myTableView.trailingAnchor)
        self.view.addConstraints([tableHeightConstraint, tableTopConstraint, tableLeftConstraint, tableRightConstraint])
    }
}
