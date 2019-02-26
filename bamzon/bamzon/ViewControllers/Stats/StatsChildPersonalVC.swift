//
//  StatsChildPersonalVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

class StatsChildPersonalVC: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource, DisplayableProtocol, EditableProtocol, RefreshableProtocol {

    var profilePictureImageView = UIImageView()
    var nameLabel = UILabel()
    var statsTable = UITableView()

    // TODO: connect to database

    let pID = ID(type: "u", num: 1234)
    let tID = ID(type: "t", num: 5678)
    let player = User(userID: ID(type: "u", num: 1234), firstName: "Jake", lastName: "Peralta", nickname: nil, phone: nil, email: "jperalt@calpoly.edu", schoolYear: Year.thirdYear, bio: "The best detective in all of Brooklyn!", imageURL: nil, teamIDs: [ID(type: "t", num: 5678)])
    let playerStats = PlayerStats(userID: ID(type: "u", num: 1234), teamID: ID(type: "t", num: 5678), fields: ["50 Free": 23.01, "100 Free": 49.67])

    let offsets: [String: CGFloat] = [
        "vertEdges": 40,
        "horizEdges": 20,
        "inTableSpacing": 12
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        display()
        statsTable.register(StatsPlayerStatsTableViewCell.self, forCellReuseIdentifier: "statCell")
        statsTable.delegate = self
        statsTable.dataSource = self
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")

        profilePictureImageView = createProfilePictureImageView(imageName: player.imageURL)
        self.view.addSubview(profilePictureImageView)

        nameLabel = createDefaultHeader1Label(text: player.getFullName(), numLines: 3)
        self.view.addSubview(nameLabel)

        self.view.addSubview(statsTable)

        setupAutoLayout()
    }

    func setupAutoLayout() {
        profilePictureImageView.translatesAutoresizingMaskIntoConstraints = false
        let picTopConstraint = profilePictureImageView.topAnchor.constraint(equalTo:
            view.topAnchor, constant: offsets["horizEdges"]!)
        let picLeftConstraint = profilePictureImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offsets["horizEdges"]!)
        let picAspectConstraint = profilePictureImageView.widthAnchor.constraint(equalTo: profilePictureImageView.heightAnchor)
        let picHeightConstraint = profilePictureImageView.heightAnchor.constraint(equalToConstant: 125)
        self.view.addConstraints([picTopConstraint, picLeftConstraint, picAspectConstraint, picHeightConstraint])

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let nameVerticalConstraint = nameLabel.centerYAnchor.constraint(equalTo: profilePictureImageView.centerYAnchor)
        let nameLeadingConstraint = nameLabel.leadingAnchor.constraint(equalTo: profilePictureImageView.trailingAnchor, constant: offsets["horizEdges"]!)
        let nameTrailingConstraint = view.trailingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: offsets["horizEdges"]!)
        self.view.addConstraints([nameVerticalConstraint, nameLeadingConstraint, nameTrailingConstraint])

        statsTable.translatesAutoresizingMaskIntoConstraints = false
        let tableTopConstraint = statsTable.topAnchor.constraint(equalTo: profilePictureImageView.bottomAnchor, constant: offsets["horizEdges"]!)
        let tableLeadingConstraint = statsTable.leadingAnchor.constraint(equalTo: profilePictureImageView.leadingAnchor)
        let tableTrailingConstraint = view.trailingAnchor.constraint(equalTo: statsTable.trailingAnchor, constant: offsets["horizEdges"]!)
        let tableBottomConstraint = view.bottomAnchor.constraint(equalTo: statsTable.bottomAnchor, constant: offsets["horizEdges"]!)
        self.view.addConstraints([tableTopConstraint, tableLeadingConstraint, tableTrailingConstraint, tableBottomConstraint])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerStats.fields?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath) as? StatsPlayerStatsTableViewCell {
            let fieldName = playerStats.fields?.keys.sorted()[indexPath.row]
            cell.eventLabel.text = fieldName
            if let prVal = playerStats.fields?[fieldName!] {
                cell.prLabel.text = "\(prVal)"
            } else {
                cell.prLabel.text = "-"
            }
            return cell
        } else {
            print("Unrecognized cell type in StatsChildPersonalVC")
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
    }
    
    func refresh() {
        // TODO: implement refresh
    }
    
    func edit() {
        // TODO: implement edit
    }

    // MARK: - Navigation

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "My Stats")
    }

    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
