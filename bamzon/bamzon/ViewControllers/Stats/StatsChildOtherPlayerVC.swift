//
//  StatsChildOtherPlayerVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/07/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class StatsChildOtherPlayerVC: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource, DisplayableProtocol {

    var statsTable = UITableView()

    let statsVM = StatsVM()

    let offsets: [String: CGFloat] = [
        "vertEdges": 40,
        "horizEdges": 20,
        "inTableSpacing": 12
    ]

    // get the team object from the database
    let team = Team(teamID: IDUtility.generateTeamID(), orgID: IDUtility.generateOrgID(), userIDs: [IDUtility.generateUserID()], teamName: "Swim Club", sport: "Swim", stats: nil, calendar: nil, joinReqIDs: nil, blacklistUserIDs: nil)
    // get the user objects from the database through the userIDs of the team
    let players = [User(userID: IDUtility.generateUserID(), firstName: "Rosa", lastName: "Diaz", nickname: nil, phone: nil, email: nil, schoolYear: nil, bio: nil, imageURL: nil, teamIDs: nil), User(userID: IDUtility.generateUserID(), firstName: "Jake", lastName: "Peralta", nickname: nil, phone: nil, email: nil, schoolYear: nil, bio: nil, imageURL: nil, teamIDs: nil), User(userID: IDUtility.generateUserID(), firstName: "Amy", lastName: "Santiago", nickname: nil, phone: nil, email: nil, schoolYear: nil, bio: nil, imageURL: nil, teamIDs: nil)]

    override func viewDidLoad() {
        super.viewDidLoad()
        statsTable.register(StatsOtherPlayerNamesTableViewCell.self, forCellReuseIdentifier: "otherPlayerCell")
        statsTable.delegate = self
        statsTable.dataSource = self
        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")

        statsTable.backgroundColor = UIColor(named: "TSTeal")
        self.view.addSubview(statsTable)

        setupAutoLayout()

    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        statsTable.translatesAutoresizingMaskIntoConstraints = false
        let tableTopConstraint = statsTable.topAnchor.constraint(equalTo: margins.topAnchor)
        let tableLeadingConstraint = statsTable.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let tableTrailingConstraint = margins.trailingAnchor.constraint(equalTo: statsTable.trailingAnchor)
        let tableBottomConstraint = margins.bottomAnchor.constraint(equalTo: statsTable.bottomAnchor)
        self.view.addConstraints([tableTopConstraint, tableLeadingConstraint, tableTrailingConstraint, tableBottomConstraint])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
        // should be:
        // return team.userIDs?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "otherPlayerCell", for: indexPath) as? StatsOtherPlayerNamesTableViewCell {
            cell.highlightYellowOnSelection()
            let player = players[indexPath.row]
            cell.nameLabel.text = player.getFullName()
            return cell
        } else {
            print("Unrecognized cell type in StatsChildOtherPlayerVC")
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Others' Stats")
    }
}
