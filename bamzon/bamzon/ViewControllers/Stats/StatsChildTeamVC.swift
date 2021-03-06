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
    
    var statTypes: [String] = []
    var stats: [String] = []
    
    let statsVM = StatsVM()

    private var statsTableView = UITableView()
    private let cellId = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.showSpinner(onView: self.view)
        let dispatch = DispatchGroup()
        statsVM.loadTeamStats(dispatch: dispatch)
        dispatch.notify(queue: DispatchQueue.main) {
            self.addAdditionalStats()
            self.statsTableView.dataSource = self
            self.statsTableView.delegate = self
            self.statsTableView.register(StatsTeamStatsViewCell.self, forCellReuseIdentifier: self.cellId)
    
            self.removeSpinner()
            self.display()
            self.setupAutoLayout()
        }
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")

        statsTableView.backgroundColor = UIColor(named: "TSTeal")
        statsTableView.allowsSelection = false
        self.view.addSubview(statsTableView)
    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        statsTableView.translatesAutoresizingMaskIntoConstraints = false
        statsTableView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        statsTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        statsTableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        statsTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }
    
    // Cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    // Number of statTypes to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statTypes.count
    }
    
    // Populate each cell with a stat type
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! StatsTeamStatsViewCell
        // swiftlint:enable force_cast
        cell.highlightYellowOnSelection()
        let statType = statTypes[indexPath.row]
        
        //TODO: Fix this
        let stat = stats[indexPath.row]
            
        cell.statsDescLabel.text = statType
        cell.statsLabel.text = "\(stat)"
        return cell
    }

    func addAdditionalStats() {
        if let teamStats = self.statsVM.teamStats {
            self.stats.append(contentsOf: [String(teamStats.wins), String(teamStats.losses), String(teamStats.ties)])
            self.statTypes.append(contentsOf: ["Wins", "Losses", "Ties"])
      
            if let additionalStats = teamStats.fields {
                for stat in additionalStats {
                    self.statTypes.append(stat.key)
                    
                    if let statAsInt = stat.value as? Int {
                        self.stats.append(String(statAsInt))
                    } else if let statAsInt = stat.value as? String {
                        self.stats.append(String(statAsInt))
                    }
                }
            }
        }
    }

    // MARK: - Navigation
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Team Stats")
    }

}
