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

    //let statTypes = ["Total Meets:", "Combined Score First Places:", "Women's Team First Places:", "Men's Team First Places:"]
    
    let statTypes = ["Wins:", "Losses:", "Ties:"]
    
    let statsVM = StatsVM()

    private var statsTableView = UITableView()
    private let cellId = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statsTableView.dataSource = self
        statsTableView.delegate = self
        statsTableView.register(StatsTeamStatsViewCell.self, forCellReuseIdentifier: self.cellId)

        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")

        statsTableView.backgroundColor = UIColor(named: "TSTeal")
        self.view.addSubview(statsTableView)

        setupAutoLayout()
    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        statsTableView.translatesAutoresizingMaskIntoConstraints = false
        statsTableView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        statsTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        statsTableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        statsTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.contentView.backgroundColor = UIColor(named: "TSYellow")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! StatsTeamStatsViewCell
    
        // swiftlint:enable force_cast
        let statType = statTypes[indexPath.row]
        let teamStats = statsVM.teamStats
        let stats = [teamStats?.wins, teamStats?.losses, teamStats?.ties]
        let stat = stats[indexPath.row]
        
        cell.statsDescLabel.text = statType
        cell.statsLabel.text = "\(stat ?? 0)"
        
        return cell
    }
    
     // MARK: - Navigation
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Team Stats")
    }
}
