//
//  SelectTeamTableViewCell.swift
//  bamzon
//
//  Created by Brandon Ryan on 21.02.19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit

class SelectTeamTableViewCell: UITableViewCell {
    
//    var imgUser = UIImageView()
    var imgUserName: String?
    var teamName = UILabel()
    var teamOrg = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "TSTeal")

//        imgUser = createProfilePictureImageView(imageName: imgUserName)

        teamName = createLabelToConstrain(withText: "Team Name", alignment: .left, boldType: "-Bold", fontSize: 20, numLines: 1, hasScaleFactor: true)
        
        teamOrg = createLabelToConstrain(withText: "Team Location", alignment: .left, boldType: "", fontSize: 17, numLines: 1, hasScaleFactor: false)
        
        addSubviews(views: [/*imgUser */teamName, teamOrg])
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews(views: [UIView]) {
        for view in views {
            contentView.addSubview(view)
        }
    }
    
    func setupAutoLayout() {
        let margins = contentView.safeAreaLayoutGuide

        let nameLeadingConstraint = teamName.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10)
        let nameTopConstraint = teamName.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10)
        let nameTrailingConstraint = margins.trailingAnchor.constraint(equalTo: teamName.trailingAnchor, constant: 10)
        self.contentView.addConstraints([nameLeadingConstraint, nameTopConstraint, nameTrailingConstraint])

        let orgLeadingConstraint = teamOrg.leadingAnchor.constraint(equalTo: teamName.leadingAnchor)
        let orgTrailingConstraint = teamName.trailingAnchor.constraint(equalTo: teamOrg.trailingAnchor)
        let orgBottomConstraint = margins.bottomAnchor.constraint(greaterThanOrEqualTo: teamOrg.bottomAnchor, constant: 10)
        let orgTopConstraint = teamOrg.topAnchor.constraint(equalTo: teamName.bottomAnchor, constant: 5)
        self.contentView.addConstraints([orgLeadingConstraint, orgTrailingConstraint, orgBottomConstraint, orgTopConstraint])

    }
}
