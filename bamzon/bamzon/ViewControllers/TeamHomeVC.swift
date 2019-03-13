//
//  TeamHomeVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class TeamHomeVC: UIViewController, DisplayableProtocol {

//    var curTeam: Team = (UIApplication.shared.delegate as! AppDelegate).curTeam
//    var curTeam = Team(teamID: IDUtility.generateTeamID(), orgID: IDUtility.generateOrgID(), userIDs: [IDUtility.generateUserID()], teamName: "Swim Club", sport: "Swim", stats: nil, calendar: nil, joinReqIDs: nil, blacklistUserIDs: nil)

    let viewModel = LoggedInViewModel()

    let offsets: [String: CGFloat] = [
        "vertEdges": 40,
        "horizEdges": 20,
        "inTableSpacing": 12
    ]
    
    var teamPictureImageView = UIImageView()
    var teamNameLabel = UILabel()
    var nextLabel = UILabel()
    var descLabel = UILabel()
    var nextEvent = UILabel()
    var eventDescLabel = UILabel()
    var timeLabel = UILabel()
    var eventDateLabel = UILabel()
    var departTimeLabel = UILabel()
    var returnTimeLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Team Home"
        display()
    }
    
    func display() {
        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "person"), style: .plain, target: self, action: #selector(profileTapped)), animated: true)

        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(showSettings)), animated: true)

        view.backgroundColor = UIColor(named: "TSTeal")
        
        let nextPracticeDesc = "Dryland - Doerr Field"
        let nextPracticeTime = "6:30 - 7:30 pm"
        let nextEventDesc = "UCLA Invite"
        let nextEventDate = "December 1, 2018"
        let departTime = "December 1 @ 8 AM"
        let returnTime = "December 1 @ 10 PM"
        
        teamPictureImageView.contentMode = .scaleAspectFill
        teamPictureImageView.clipsToBounds = true
        // TODO: update to be a team-specific photo
        teamPictureImageView.image = UIImage(named: "BZN-Square-Logo")
        teamPictureImageView.layer.cornerRadius = 15.0
        self.view.addSubview(teamPictureImageView)

        teamNameLabel = createDefaultHeader1Label(text: viewModel.team.teamName, numLines: 3)
        teamNameLabel.lineBreakMode = .byWordWrapping
        self.view.addSubview(teamNameLabel)
        
        //Label for Next Practice
        nextLabel = createDefaultLabel(text: "Next Practice", fontSize: 25, numLines: 0)
        self.view.addSubview(nextLabel)

        descLabel = createDefaultLabel(text: nextPracticeDesc)
        self.view.addSubview(descLabel)

        timeLabel = createDefaultLabel(text: nextPracticeTime, numLines: 0)
        self.view.addSubview(timeLabel)

        nextEvent = createDefaultLabel(text: "Next Event", fontSize: 25, numLines: 0)
        self.view.addSubview(nextEvent)

        eventDescLabel = createDefaultLabel(text: nextEventDesc)
        self.view.addSubview(eventDescLabel)

        eventDateLabel = createDefaultLabel(text: nextEventDate, numLines: 0)
        self.view.addSubview(eventDateLabel)

        departTimeLabel = createDefaultLabel(text: "Leaving \(departTime)", numLines: 0)
        self.view.addSubview(departTimeLabel)

        returnTimeLabel = createDefaultLabel(text: "Returning \(returnTime)", numLines: 0)
        self.view.addSubview(returnTimeLabel)

        setupAutoLayout()
    }

    @objc func profileTapped(sender: UIBarButtonItem) {
        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC")
        self.navigationController!.present(profileVC, animated: true, completion: nil)
    }

    @objc func showSettings(sender: UIBarButtonItem) {
        let settingsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC")
        self.navigationController!.present(settingsVC, animated: true, completion: nil)
    }

    func setupAutoLayout() {
        let margins = view.layoutMarginsGuide

        //image view constraints
        teamPictureImageView.translatesAutoresizingMaskIntoConstraints = false
        let picTopConstraint = teamPictureImageView.topAnchor.constraint(equalTo: margins.topAnchor, constant: offsets["horizEdges"]!)
        let picLeftConstraint = teamPictureImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: offsets["horizEdges"]!)
        let picWidthConstraint = teamPictureImageView.widthAnchor.constraint(equalToConstant: 125)
        let picDimensionConstraint = teamPictureImageView.heightAnchor.constraint(equalTo: teamPictureImageView.widthAnchor)
        self.view.addConstraints([picTopConstraint, picLeftConstraint, picWidthConstraint, picDimensionConstraint])

        //team name constraints
        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let tNameVertConstraint = teamNameLabel.centerYAnchor.constraint(equalTo: teamPictureImageView.centerYAnchor)
        let tNameHeightConstraint = teamNameLabel.heightAnchor.constraint(equalTo: teamPictureImageView.heightAnchor)
        let tNameLeadingConstraint = teamNameLabel.leadingAnchor.constraint(equalTo: teamPictureImageView.trailingAnchor, constant: offsets["horizEdges"]!)
        let tNameTrailingConstraint = teamNameLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: offsets["horizEdges"]!)
        self.view.addConstraints([tNameVertConstraint, tNameHeightConstraint, tNameLeadingConstraint, tNameTrailingConstraint])

        //next practice label constraints
        nextLabel.translatesAutoresizingMaskIntoConstraints = false
        let nextLabelLeftConstraint = nextLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: offsets["horizEdges"]!)
        let nextLabelTopConstraint = nextLabel.topAnchor.constraint(equalTo: teamPictureImageView.bottomAnchor, constant: 30)
        self.view.addConstraints([nextLabelLeftConstraint, nextLabelTopConstraint])

        //description constraints
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        let descTopConstraint = descLabel.topAnchor.constraint(equalTo: nextLabel.bottomAnchor, constant: 10)
        let descLeftConstraint = descLabel.leadingAnchor.constraint(equalTo: nextLabel.leadingAnchor, constant: 10)
        let descRightConstraint = margins.trailingAnchor.constraint(equalTo: descLabel.trailingAnchor, constant: offsets["horizEdges"]!)
        self.view.addConstraints([descTopConstraint, descLeftConstraint, descRightConstraint])

        //time label constraints
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        let timeTopConstraint = timeLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 5)
        let timeLeftConstraint = timeLabel.leadingAnchor.constraint(equalTo: nextLabel.leadingAnchor, constant: 10)
        self.view.addConstraints([timeTopConstraint, timeLeftConstraint])

        //next event label constraints
        nextEvent.translatesAutoresizingMaskIntoConstraints = false
        let nextEventLeftConstraint = nextEvent.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: offsets["horizEdges"]!)
        let nextEventTopConstraint = nextEvent.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: offsets["horizEdges"]!)
        self.view.addConstraints([nextEventLeftConstraint, nextEventTopConstraint])

        //description constraints
        eventDescLabel.translatesAutoresizingMaskIntoConstraints = false
        let eventDescTopConstraint = eventDescLabel.topAnchor.constraint(equalTo: nextEvent.bottomAnchor, constant: 10)
        let eventDescLeftConstraint = eventDescLabel.leadingAnchor.constraint(equalTo: nextEvent.leadingAnchor, constant: 10)
        let eventDescRightConstraint = margins.trailingAnchor.constraint(equalTo: eventDescLabel.trailingAnchor, constant: offsets["horizEdges"]!)
        self.view.addConstraints([eventDescTopConstraint, eventDescLeftConstraint, eventDescRightConstraint])

        //event date label constraints
        eventDateLabel.translatesAutoresizingMaskIntoConstraints = false
        let eventDateTopConstraint = eventDateLabel.topAnchor.constraint(equalTo: eventDescLabel.bottomAnchor, constant: 5)
        let eventDateLeftConstraint = eventDateLabel.leadingAnchor.constraint(equalTo: nextEvent.leadingAnchor, constant: 10)
        self.view.addConstraints([eventDateTopConstraint, eventDateLeftConstraint])

        //depart time label constraints
        departTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        let departTopConstraint = departTimeLabel.topAnchor.constraint(equalTo: eventDateLabel.bottomAnchor, constant: 5)
        let departLeftConstraint = departTimeLabel.leadingAnchor.constraint(equalTo: nextEvent.leadingAnchor, constant: 10)
        self.view.addConstraints([departTopConstraint, departLeftConstraint])

        //return time label constraints
        returnTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        let returnTopConstraint = returnTimeLabel.topAnchor.constraint(equalTo: departTimeLabel.bottomAnchor, constant: 5)
        let returnLeftConstraint = returnTimeLabel.leadingAnchor.constraint(equalTo: nextEvent.leadingAnchor, constant: 10)
        self.view.addConstraints([returnTopConstraint, returnLeftConstraint])

    }
}
