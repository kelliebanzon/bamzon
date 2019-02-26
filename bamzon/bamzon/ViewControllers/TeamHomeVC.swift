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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Team Home"
        display()
    }
    
    func display() {
        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "person"), style: .plain, target: self, action: #selector(profileTapped)), animated: true)

        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: nil, action: nil), animated: true)

        view.backgroundColor = UIColor(named: "TSTeal")
        
        let tName = "Cal Poly Swim Club"
        let memberCount = 78
        let nextPracticeDesc = "Dryland - Doerr Field"
        let nextPracticeTime = "6:30 - 7:30 pm"
        let nextEventDesc = "UCLA Invite"
        let nextEventDate = "December 1, 2018"
        let departTime = "December 1 @ 8 AM"
        let returnTime = "December 1 @ 10 PM"
        
        //image view
        let teamPictureImageView = UIImageView()
        
        teamPictureImageView.contentMode = .scaleAspectFill
        teamPictureImageView.clipsToBounds = true
        teamPictureImageView.image = UIImage(named: "BZN-Square-Logo")
        teamPictureImageView.layer.cornerRadius = 15.0
        teamPictureImageView.setContentCompressionResistancePriority(UILayoutPriority(750), for: .horizontal)
        
        self.view.addSubview(teamPictureImageView)
        
        //image view constraints
        teamPictureImageView.translatesAutoresizingMaskIntoConstraints = false
        let picTopConstraint = teamPictureImageView.topAnchor.constraint(equalTo:
            view.topAnchor, constant: 70)
        let picLeftConstraint = teamPictureImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        let picWidthConstraint = teamPictureImageView.widthAnchor.constraint(equalToConstant: 125)
        let picHeightConstraint = teamPictureImageView.heightAnchor.constraint(equalToConstant: 125)
        self.view.addConstraints([picTopConstraint, picLeftConstraint, picWidthConstraint, picHeightConstraint])
        
        //member count label
        let memberCountLabel = UILabel()
        memberCountLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        memberCountLabel.numberOfLines = 1
        memberCountLabel.textColor = .white
        memberCountLabel.textAlignment = .left
        memberCountLabel.text = "Member count: \(memberCount)"
        memberCountLabel.minimumScaleFactor = 0.25
        memberCountLabel.adjustsFontSizeToFitWidth = true
        memberCountLabel.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        self.view.addSubview(memberCountLabel)
        
        //member count label constraints
        memberCountLabel.translatesAutoresizingMaskIntoConstraints = false
        let memberBottomConstraint = memberCountLabel.bottomAnchor.constraint(equalTo: teamPictureImageView.bottomAnchor)
        let memberLeftConstraint = memberCountLabel.leadingAnchor.constraint(equalTo: teamPictureImageView.trailingAnchor, constant: 20)
        let memberRightConstraint = view.trailingAnchor.constraint(equalTo: memberCountLabel.trailingAnchor, constant: 20)
        
        self.view.addConstraints([memberBottomConstraint, memberLeftConstraint, memberRightConstraint])
        
        //team name
        let teamNameLabel = UILabel()
        teamNameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        teamNameLabel.numberOfLines = 3
        teamNameLabel.textColor = .white
        teamNameLabel.textAlignment = .left
        teamNameLabel.text = tName
        teamNameLabel.minimumScaleFactor = 0.25
        teamNameLabel.adjustsFontSizeToFitWidth = true
        teamNameLabel.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        self.view.addSubview(teamNameLabel)
        
        //team name constraints
        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let tNameBottomConstraint = teamNameLabel.bottomAnchor.constraint(equalTo: memberCountLabel.topAnchor, constant: -2)
        let tNameLeftConstraint = teamNameLabel.leadingAnchor.constraint(equalTo: teamPictureImageView.trailingAnchor, constant: 20)
        let tNameRightConstraint = view.trailingAnchor.constraint(equalTo: teamNameLabel.trailingAnchor, constant: 20)
        self.view.addConstraints([tNameBottomConstraint, tNameLeftConstraint, tNameRightConstraint])
        
        //Label for Next Practice
        let nextLabel = UILabel()
        nextLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        nextLabel.numberOfLines = 0
        nextLabel.textColor = .white
        nextLabel.textAlignment = .left
        nextLabel.text = "Next Practice"
        self.view.addSubview(nextLabel)
        
        //next practice label constraints
        nextLabel.translatesAutoresizingMaskIntoConstraints = false
        let nextLabelLeftConstraint = nextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let nextLabelTopConstraint = nextLabel.topAnchor.constraint(equalTo: teamPictureImageView.bottomAnchor, constant: 30)
        self.view.addConstraints([nextLabelLeftConstraint, nextLabelTopConstraint])
        
        //description label
        let descLabel = UILabel()
        descLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        descLabel.numberOfLines = 1
        descLabel.textColor = .white
        descLabel.textAlignment = .left
        descLabel.text = nextPracticeDesc
        descLabel.minimumScaleFactor = 0.25
        descLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(descLabel)
        
        //description constraints
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        let descTopConstraint = descLabel.topAnchor.constraint(equalTo: nextLabel.bottomAnchor, constant: 10)
        let descLeftConstraint = descLabel.leadingAnchor.constraint(equalTo: nextLabel.leadingAnchor, constant: 10)
        let descRightConstraint = self.view.trailingAnchor.constraint(equalTo: descLabel.trailingAnchor, constant: 20)
        self.view.addConstraints([descTopConstraint, descLeftConstraint, descRightConstraint])
        
        //time label
        let timeLabel = UILabel()
        timeLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        timeLabel.numberOfLines = 0
        timeLabel.textColor = .white
        timeLabel.textAlignment = .left
        timeLabel.text = nextPracticeTime
        self.view.addSubview(timeLabel)
        
        //time label constraints
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        let timeTopConstraint = timeLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 5)
        let timeLeftConstraint = timeLabel.leadingAnchor.constraint(equalTo: nextLabel.leadingAnchor, constant: 10)
        self.view.addConstraints([timeTopConstraint, timeLeftConstraint])
        
        //Label for Next Event
        let nextEvent = UILabel()
        nextEvent.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        nextEvent.numberOfLines = 0
        nextEvent.textColor = .white
        nextEvent.textAlignment = .left
        nextEvent.text = "Next Event"
        self.view.addSubview(nextEvent)
        
        //next event label constraints
        nextEvent.translatesAutoresizingMaskIntoConstraints = false
        let nextEventLeftConstraint = nextEvent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let nextEventTopConstraint = nextEvent.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20)
        self.view.addConstraints([nextEventLeftConstraint, nextEventTopConstraint])
        
        //description label
        let eventDescLabel = UILabel()
        eventDescLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        eventDescLabel.numberOfLines = 1
        eventDescLabel.textColor = .white
        eventDescLabel.textAlignment = .left
        eventDescLabel.text = nextEventDesc
        eventDescLabel.minimumScaleFactor = 0.25
        eventDescLabel.adjustsFontSizeToFitWidth = true
        self.view.addSubview(eventDescLabel)
        
        //description constraints
        eventDescLabel.translatesAutoresizingMaskIntoConstraints = false
        let eventDescTopConstraint = eventDescLabel.topAnchor.constraint(equalTo: nextEvent.bottomAnchor, constant: 10)
        let eventDescLeftConstraint = eventDescLabel.leadingAnchor.constraint(equalTo: nextEvent.leadingAnchor, constant: 10)
        let eventDescRightConstraint = self.view.trailingAnchor.constraint(equalTo: eventDescLabel.trailingAnchor, constant: 20)
        self.view.addConstraints([eventDescTopConstraint, eventDescLeftConstraint, eventDescRightConstraint])
        
        //event date label
        let eventDateLabel = UILabel()
        eventDateLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        eventDateLabel.numberOfLines = 0
        eventDateLabel.textColor = .white
        eventDateLabel.textAlignment = .left
        eventDateLabel.text = nextEventDate
        self.view.addSubview(eventDateLabel)
        
        //event date label constraints
        eventDateLabel.translatesAutoresizingMaskIntoConstraints = false
        let eventDateTopConstraint = eventDateLabel.topAnchor.constraint(equalTo: eventDescLabel.bottomAnchor, constant: 5)
        let eventDateLeftConstraint = eventDateLabel.leadingAnchor.constraint(equalTo: nextEvent.leadingAnchor, constant: 10)
        self.view.addConstraints([eventDateTopConstraint, eventDateLeftConstraint])
        
        //depart time label
        let departTimeLabel = UILabel()
        departTimeLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        departTimeLabel.numberOfLines = 0
        departTimeLabel.textColor = .white
        departTimeLabel.textAlignment = .left
        departTimeLabel.text = "Leaving \(departTime)"
        self.view.addSubview(departTimeLabel)
        
        //depart time label constraints
        departTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        let departTopConstraint = departTimeLabel.topAnchor.constraint(equalTo: eventDateLabel.bottomAnchor, constant: 5)
        let departLeftConstraint = departTimeLabel.leadingAnchor.constraint(equalTo: nextEvent.leadingAnchor, constant: 10)
        self.view.addConstraints([departTopConstraint, departLeftConstraint])
        
        //return time label
        let returnTimeLabel = UILabel()
        returnTimeLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        returnTimeLabel.numberOfLines = 0
        returnTimeLabel.textColor = .white
        returnTimeLabel.textAlignment = .left
        returnTimeLabel.text = "Returning \(returnTime)"
        self.view.addSubview(returnTimeLabel)
        
        //return time label constraints
        returnTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        let returnTopConstraint = returnTimeLabel.topAnchor.constraint(equalTo: departTimeLabel.bottomAnchor, constant: 5)
        let returnLeftConstraint = returnTimeLabel.leadingAnchor.constraint(equalTo: nextEvent.leadingAnchor, constant: 10)
        self.view.addConstraints([returnTopConstraint, returnLeftConstraint])
    }

    @objc func profileTapped(sender: UIBarButtonItem) {
        mockSegue(toIdentifier: "ProfileVC")
    }
    
    func viewStats() {
        // TODO: implement view stats
    }
    
    func viewRoster() {
        // TODO: implement view roster
    }
    
    func viewCalendar() {
        // TODO: implement view calendar
    }
    
    func viewAttendance() {
        // TODO: implement view attendance
    }
    
    func viewSettings() {
        // TODO: implement view settings
    }
}
