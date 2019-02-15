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
        // TODO: implement display
        view.backgroundColor = UIColor(named: "TSTeal")
        
        // TODO: change these to user names
        let tName = "Cal Poly Swim Club"
        let memberCount = 78
        //let nextPracticeLoc = "Dryland - Doerr Field"
        //let nextPracticeTime = "6:30 - 7:30 pm"
        
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
        
        // TODO: temporary identifier code. delete this once you write the real display func
        // Temp Label
        /*let tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 120))
        tempLabel.center = CGPoint(x: view.frame.midX, y: view.frame.midY)
        tempLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        tempLabel.textAlignment = .ce nter
        tempLabel.numberOfLines = 1
        tempLabel.textColor = .white
        tempLabel.text = "TeamHomeVC"
        self.view.addSubview(tempLabel)*/
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
