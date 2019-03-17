//
//  AttendancePlayerVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 01/27/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class AttendancePlayerVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DisplayableProtocol, EditableProtocol, RefreshableProtocol {

    let events = [Event(eventID: IDUtility.generateEventID(), teamID: IDUtility.generateTeamID(), name: "Practice", locationID: nil, contactUserIDs: [:], description: "Dry Land", date: nil, tags: [:], media: [:], links: [:])]

    // TODO: connect to database
    var player: User = User(userID: IDUtility.generateUserID(), firstName: "Jake", lastName: "Peralta", nickname: nil, phone: nil, email: nil, schoolYear: nil, bio: nil, imageURL: nil, teamIDs: [:])

    var profilePictureImageView = UIImageView()
    var nameLabel = UILabel()
    let pracStatsLabel = UILabel()
    let attTable = UITableView()

    let offsets: [String: CGFloat] = [
        "vertEdges": 40,
        "horizEdges": 20,
        "inTableSpacing": 12
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        attTable.delegate = self
        attTable.dataSource = self
        attTable.register(AttendancePlayerTableViewCell.self, forCellReuseIdentifier: "attCell")
        display()
    }
    
    func display() {
        self.view.backgroundColor = UIColor(named: "TSTeal")

        profilePictureImageView = ImageUtility().createProfilePictureImageView(imageName: player.imageURL, style: .squircle)
        self.view.addSubview(profilePictureImageView)

        nameLabel = createDefaultHeader1Label(text: player.getFullName(), numLines: 3)
        self.view.addSubview(nameLabel)

        pracStatsLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        pracStatsLabel.textColor = .white
        pracStatsLabel.numberOfLines = 2
        pracStatsLabel.text = "Practice Count: " + String(21) + "\nPractice Percentage: " + String(52) + "%"
        self.view.addSubview(pracStatsLabel)

        attTable.allowsSelection = false
        self.view.addSubview(attTable)

        setupAutoLayout()
    }

    func setupAutoLayout() {
        profilePictureImageView.translatesAutoresizingMaskIntoConstraints = false
        let picTopConstraint = profilePictureImageView.topAnchor.constraint(equalTo:
            view.topAnchor, constant: offsets["vertEdges"]!)
        let picLeftConstraint = profilePictureImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offsets["horizEdges"]!)
        let picAspectConstraint = profilePictureImageView.widthAnchor.constraint(equalTo: profilePictureImageView.heightAnchor)
        let picHeightConstraint = profilePictureImageView.heightAnchor.constraint(equalToConstant: 125)
        self.view.addConstraints([picTopConstraint, picLeftConstraint, picAspectConstraint, picHeightConstraint])

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let nameVerticalConstraint = nameLabel.centerYAnchor.constraint(equalTo: profilePictureImageView.centerYAnchor)
        let nameLeadingConstraint = nameLabel.leadingAnchor.constraint(equalTo: profilePictureImageView.trailingAnchor, constant: offsets["horizEdges"]!)
        let nameTrailingConstraint = view.trailingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: offsets["horizEdges"]!)
        self.view.addConstraints([nameVerticalConstraint, nameLeadingConstraint, nameTrailingConstraint])

        pracStatsLabel.translatesAutoresizingMaskIntoConstraints = false
        let pracStatsTopConstraint = pracStatsLabel.topAnchor.constraint(equalTo: profilePictureImageView.bottomAnchor, constant: offsets["horizEdges"]!)
        let pracStatsLeadingConstraint = pracStatsLabel.leadingAnchor.constraint(equalTo: profilePictureImageView.leadingAnchor)
        let pracStatsTrailingConstraint = pracStatsLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: offsets["horizEdges"]!)
        self.view.addConstraints([pracStatsTopConstraint, pracStatsLeadingConstraint, pracStatsTrailingConstraint])

        attTable.translatesAutoresizingMaskIntoConstraints = false
        let attTableTopConstraint = attTable.topAnchor.constraint(equalTo: pracStatsLabel.bottomAnchor, constant: offsets["horizEdges"]!)
        let attTableLeadingConstraint = attTable.leadingAnchor.constraint(equalTo: profilePictureImageView.leadingAnchor)
        let attTableTrailingConstraint = view.trailingAnchor.constraint(equalTo: attTable.trailingAnchor, constant: offsets["horizEdges"]!)
        let attTableBottomConstraint = view.bottomAnchor.constraint(equalTo: attTable.bottomAnchor, constant: offsets["vertEdges"]!)
        self.view.addConstraints([attTableTopConstraint, attTableLeadingConstraint, attTableTrailingConstraint, attTableBottomConstraint])
    }

    // Number of events to display
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    // Populate each cell with an event
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "attCell", for: indexPath) as? AttendancePlayerTableViewCell {
            let event = events[indexPath.row]
            cell.nameLabel.text = event.name
            cell.dateLabel.text = event.date.description
//            cell.locationLabel.text = event.locationID?.street TODO NEEDS QUERY FOR LOCATION
            return cell
        } else {
            print("Unrecognized cell type in AttendancePlayerVC")
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
    }

    // Cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // Section Headers
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableFrame = attTable.frame
        let headerView = UIView(frame: CGRect(x: tableFrame.minX, y: tableFrame.minY, width: tableFrame.width, height: 10))
        headerView.backgroundColor = UIColor(named: "TSOrange")

        let headerFrame = headerView.frame
        let headerLabel = UILabel(frame: CGRect(x: 12, y: 4, width: 40, height: 20))
        headerLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 14)
        headerLabel.text = "Event"
        headerView.addSubview(headerLabel)

        print(tableFrame)
        print(headerFrame)
        print(headerLabel.frame)
        return headerView
    }

    func edit() {
        // TODO: implement edit
    }
    
    func refresh() {
        attTable.reloadData()
    }

}
