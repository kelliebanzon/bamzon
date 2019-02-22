//
//  AttendancePlayerVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 01/27/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class AttendancePlayerVC: UIViewController, UITableViewDelegate, UITableViewDataSource, DisplayableProtocol, EditableProtocol, RefreshableProtocol {

    let events = [Event(eventID: IDUtility.generateEventID(), teamID: IDUtility.generateTeamID(), name: "Practice", location: Location(locID: IDUtility.generateLocationID(), name: "Heyer Pool", number: "1", street: "Grand Ave", street2: nil, city: "San Luis Obispo", state: "CA", zip: 93405, country: "United States"), contactUserIDs: nil, description: "Dry land", date: "Tomorrow", rsvps: nil, tags: nil, media: nil, links: nil)]

    let profilePictureImageView = UIImageView()
    let nameLabel = UILabel()
    let pracStatsLabel = UILabel()
    let attTable = UITableView()

    let offsets: [String: CGFloat] = [
        "vertEdges": 40,
        "horizEdges": 20,
        "inTableSpacing": 12
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        display()
        attTable.register(AttendancePlayerTVCell.self, forCellReuseIdentifier: "attCell")
    }
    
    func display() {
        self.view.backgroundColor = UIColor(named: "TSTeal")

        profilePictureImageView.contentMode = .scaleAspectFill
        profilePictureImageView.clipsToBounds = true
        profilePictureImageView.image = UIImage(named: "BZN-Square-Logo")
        profilePictureImageView.roundCorners()
        //profilePictureImageView.layer.cornerRadius = 15.0
        //profilePictureImageView.setContentCompressionResistancePriority(UILayoutPriority(750), for: .horizontal)
        self.view.addSubview(profilePictureImageView)

        nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        nameLabel.numberOfLines = 3
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left
        nameLabel.text = "Jake Peralta"
        nameLabel.minimumScaleFactor = 0.8
        nameLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(nameLabel)

        pracStatsLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        pracStatsLabel.textColor = .white
        pracStatsLabel.numberOfLines = 2
        pracStatsLabel.text = "Practice Count: " + String(21) + "\nPractice Percentage: " + String(52) + "%"
        self.view.addSubview(pracStatsLabel)

        attTable.allowsSelection = false
        attTable.delegate = self
        attTable.dataSource = self
        self.view.addSubview(attTable)

        configureConstraints()
    }

    func configureConstraints() {
        // TODO: clean up
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: connect this to the actual number of events to display
        return events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "attCell", for: indexPath) as? AttendancePlayerTVCell {
            let event = events[indexPath.row]
            cell.nameLabel.text = event.name
            cell.dateLabel.text = event.date?.description
            cell.locationLabel.text = event.location?.street
            return cell
        } else {
            print("Unrecognized cell type in AttendancePlayerVC")
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

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
        // TODO: implement refresh: should be able to pull down and refresh entire
        // screen, not just the table view
        attTable.reloadData()
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
