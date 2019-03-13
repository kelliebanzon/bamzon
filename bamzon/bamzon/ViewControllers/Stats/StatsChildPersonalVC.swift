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
    var vm = PlayerStatsVM()
    var nameLabel = UILabel()
    var statsTable = UITableView()

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
        refresh()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")

        profilePictureImageView = createProfilePictureImageView(imageName: vm.user.imageURL)
        self.view.addSubview(profilePictureImageView)

        nameLabel = createDefaultHeader1Label(text: vm.user.getFullName(), numLines: 3)
        self.view.addSubview(nameLabel)

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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.playerStats?.fields?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath) as? StatsPlayerStatsTableViewCell {
            let fieldName = vm.playerStats?.fields?.keys.sorted()[indexPath.row]
            cell.eventLabel.text = fieldName
            if let prVal = vm.playerStats?.fields?[fieldName!] {
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
        vm.refresh(playerStatsVC: self)
    }
    
    func edit() {
        // TODO: implement edit
    }

    // MARK: - Navigation

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "My Stats")
    }

}
