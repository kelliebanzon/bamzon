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

    let playerStatsVM = PlayerStatsVM()

    let offsets: [String: CGFloat] = [
        "vertEdges": 40,
        "horizEdges": 20,
        "inTableSpacing": 12
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        statsTable.register(StatsPlayerStatsTableViewCell.self, forCellReuseIdentifier: "statCell")
        statsTable.delegate = self
        statsTable.dataSource = self
        refresh()
        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")

        profilePictureImageView = ImageUtility().createProfilePictureImageView(imageName: playerStatsVM.user.imageURL, style: .squircle)
        self.view.addSubview(profilePictureImageView)

        nameLabel = createDefaultHeader1Label(text: playerStatsVM.user.getFullName(), numLines: 3)
        self.view.addSubview(nameLabel)

        statsTable.backgroundColor = .clear
        statsTable.reloadData()
        statsTable.allowsSelection = false
        self.view.addSubview(statsTable)

        setupAutoLayout()
    }

    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide
        profilePictureImageView.translatesAutoresizingMaskIntoConstraints = false
        let picTopConstraint = profilePictureImageView.topAnchor.constraint(equalTo:
            margins.topAnchor, constant: offsets["horizEdges"]!)
        let picLeftConstraint = profilePictureImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: offsets["horizEdges"]!)
        let picAspectConstraint = profilePictureImageView.widthAnchor.constraint(equalTo: profilePictureImageView.heightAnchor)
        let picHeightConstraint = profilePictureImageView.heightAnchor.constraint(equalToConstant: 125)
        self.view.addConstraints([picTopConstraint, picLeftConstraint, picAspectConstraint, picHeightConstraint])

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let nameVerticalConstraint = nameLabel.centerYAnchor.constraint(equalTo: profilePictureImageView.centerYAnchor)
        let nameLeadingConstraint = nameLabel.leadingAnchor.constraint(equalTo: profilePictureImageView.trailingAnchor, constant: offsets["horizEdges"]!)
        let nameTrailingConstraint = margins.trailingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: offsets["horizEdges"]!)
        self.view.addConstraints([nameVerticalConstraint, nameLeadingConstraint, nameTrailingConstraint])

        statsTable.translatesAutoresizingMaskIntoConstraints = false
        let tableTopConstraint = statsTable.topAnchor.constraint(equalTo: profilePictureImageView.bottomAnchor, constant: offsets["horizEdges"]!)
        let tableLeadingConstraint = statsTable.leadingAnchor.constraint(equalTo: profilePictureImageView.leadingAnchor)
        let tableTrailingConstraint = margins.trailingAnchor.constraint(equalTo: statsTable.trailingAnchor, constant: offsets["horizEdges"]!)
        let tableBottomConstraint = margins.bottomAnchor.constraint(equalTo: statsTable.bottomAnchor, constant: offsets["horizEdges"]!)
        self.view.addConstraints([tableTopConstraint, tableLeadingConstraint, tableTrailingConstraint, tableBottomConstraint])
    }

    // Number of players to dislay
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerStatsVM.playerStats?.fields?.count ?? 0
    }

    // Populate each cell with a player
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath) as? StatsPlayerStatsTableViewCell {
            let fieldName = playerStatsVM.playerStats?.fields?.keys.sorted()[indexPath.row]
            cell.eventLabel.text = fieldName
            if let prVal = playerStatsVM.playerStats?.fields?[fieldName!] {
                cell.valueLabel.text = "\(prVal)"
            } else {
                cell.valueLabel.text = "-"
            }
            return cell
        } else {
            print("Unrecognized cell type in StatsChildPersonalVC")
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
    }

    // Cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func refresh() {
        playerStatsVM.refresh(playerStatsVC: self)
        display()
    }
    
    func edit() {
        // TODO: implement edit
    }

    // MARK: - Navigation

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "My Stats")
    }

}
