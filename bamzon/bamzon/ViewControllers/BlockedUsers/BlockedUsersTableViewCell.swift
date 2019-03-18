//
//  BlockedUsersTableViewCell.swift
//  bamzon
//
//  Created by Kyle Vu on 3/17/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class BlockedUsersTableViewCell: UITableViewCell {
    
    var userName = UILabel()
    var unblockButton = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "TSTeal")
        
        userName = createLabelToConstrain(withText: "Blocked User", alignment: .left, boldType: "-Bold", fontSize: 20, numLines: 1, hasScaleFactor: true)
        
        unblockButton = createButtonToConstrain(withText: "Unblock", size: 12)
        
        addSubviews()
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(userName)
        contentView.addSubview(unblockButton)
    }
    
    func setupAutoLayout() {
        
        // Name constraints
        let nameLeftConstraint = userName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        let nameTopConstraint = userName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15)
        let nameWidthConstraint = userName.widthAnchor.constraint(equalToConstant: 130)
        self.contentView.addConstraints([nameLeftConstraint, nameTopConstraint, nameWidthConstraint])
        
        // Unblock constraints
        let unblockRightConstraint = self.contentView.trailingAnchor.constraint(equalTo: unblockButton.trailingAnchor, constant: 10)
        let unblockTopConstraint = unblockButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        let unblockWidthConstraint = unblockButton.widthAnchor.constraint(equalToConstant: 50)
        self.contentView.addConstraints([unblockRightConstraint, unblockTopConstraint, unblockWidthConstraint])//, teamWidthConstraint])
        
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
