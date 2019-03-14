//
//  JoinRequestTableViewCell.swift
//  bamzon
//
//  Created by Brandon Ryan on 23.02.19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit

class RequestTableViewCell: UITableViewCell {
    
    let joinRequestsVM = JoinRequestsVM()
    var userName = UILabel()
    var teamName = UILabel()
    var acceptButton = UIButton()
    var rejectButton = UIButton()
    var blockButton = UIButton()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "TSTeal")
        
        userName = createLabelToConstrain(withText: "Requestor Name", alignment: .left, boldType: "-Bold", fontSize: 20, numLines: 1, hasScaleFactor: true)
        
        teamName = createLabelToConstrain(withText: "Team Location", alignment: .left, boldType: "-Bold", fontSize: 20, numLines: 1, hasScaleFactor: true)
        
        acceptButton = createButtonToConstrain(withText: "Accept", size: 12)
        acceptButton.addTarget(self, action: #selector(joinRequestsVM.approve), for: .touchUpInside)
        
        rejectButton = createButtonToConstrain(withText: "Reject", size: 12)
        
        blockButton = createButtonToConstrain(withText: "Block", size: 12)
        
        addSubviews()
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(userName)
        contentView.addSubview(teamName)
        contentView.addSubview(acceptButton)
        contentView.addSubview(rejectButton)
        contentView.addSubview(blockButton)
    }
    
    func setupAutoLayout() {
        
        //name constraints
        let nameLeftConstraint = userName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        let nameTopConstraint = userName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15)
        let nameWidthConstraint = userName.widthAnchor.constraint(equalToConstant: 130)
        self.contentView.addConstraints([nameLeftConstraint, nameTopConstraint, nameWidthConstraint])
        
        //team name constraints
        let teamLeftConstraint = teamName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        let teamTopConstraint = teamName.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 5)
        let teamWidthConstraint = teamName.widthAnchor.constraint(equalToConstant: 130)
        self.contentView.addConstraints([teamLeftConstraint, teamTopConstraint, teamWidthConstraint])
        
        //block constraints
        let blockRightConstraint = self.contentView.trailingAnchor.constraint(equalTo: blockButton.trailingAnchor, constant: 10)
        let blockTopConstraint = blockButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        let blockWidthConstraint = blockButton.widthAnchor.constraint(equalToConstant: 50)
        self.contentView.addConstraints([blockRightConstraint, blockTopConstraint, blockWidthConstraint])//, teamWidthConstraint])
        
        //accept constraints
        let acceptLeftConstraint = acceptButton.leadingAnchor.constraint(greaterThanOrEqualTo: userName.trailingAnchor, constant: 10)
        let acceptTopConstraint = acceptButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        let acceptWidthConstraint = acceptButton.widthAnchor.constraint(equalToConstant: 50)
        self.contentView.addConstraints([acceptLeftConstraint, acceptTopConstraint, acceptWidthConstraint])
        
        //reject constraints
        let rejectRightConstraint = rejectButton.trailingAnchor.constraint(equalTo: blockButton.leadingAnchor, constant: -5)
        let rejectTopConstraint = rejectButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        let rejectLeftConstraint = rejectButton.leadingAnchor.constraint(equalTo: acceptButton.trailingAnchor, constant: 5)
        let rejectWidthConstraint = rejectButton.widthAnchor.constraint(equalToConstant: 50)
        self.contentView.addConstraints([rejectRightConstraint, rejectTopConstraint, rejectLeftConstraint, rejectWidthConstraint])
        
    }
    // Highlight the button upon touchDown
    @objc override func highlightButton(sender: UIButton!) {
        sender.backgroundColor = UIColor(named: "TSYellowDark")
    }
    
    // Unhighlight the button upon touchDown
    @objc override func unhighlightButton(sender: UIButton!) {
        sender.backgroundColor = UIColor(named: "TSYellow")
    }
}
