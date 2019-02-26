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
    
    var imgUser = UIImageView()
    var teamName = UILabel()
    var teamLocation = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "TSTeal")
        
        imgUser = createDefaultPic()
        
        teamName = createLabelToConstrain(withText: "Team Name", alignment: .left, boldType: "-Bold", fontSize: 20, numLines: 1, hasScaleFactor: true)
        
        teamLocation = createLabelToConstrain(withText: "Team Location", alignment: .left, boldType: "", fontSize: 17, numLines: 1, hasScaleFactor: false)
        
        addSubviews()
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(teamName)
        contentView.addSubview(imgUser)
        contentView.addSubview(teamLocation)
    }
    
    func setupAutoLayout() {
        //image constraints
        let imgLeftConstraint = imgUser.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        let imgVertConstraint = imgUser.topAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -35)
        let imgWidthConstraint = imgUser.widthAnchor.constraint(equalToConstant: 70)
        let imgHeightConstraint = imgUser.heightAnchor.constraint(equalToConstant: 70)
        self.contentView.addConstraints([imgLeftConstraint, imgVertConstraint, imgWidthConstraint, imgHeightConstraint])
        
        //name constraints
        let nameLeftConstraint = teamName.leadingAnchor.constraint(equalTo: imgUser.trailingAnchor, constant: 15)
        let nameTopConstraint = teamName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        let nameWidthConstraint = teamName.widthAnchor.constraint(equalToConstant: 100)
        self.contentView.addConstraints([nameLeftConstraint, nameTopConstraint, nameWidthConstraint])
        
        //number constraints
        let numLeftConstraint = teamLocation.leadingAnchor.constraint(equalTo: imgUser.trailingAnchor, constant: 15)
        let numTopConstraint = teamLocation.topAnchor.constraint(equalTo: teamName.bottomAnchor, constant: 5)
        self.contentView.addConstraints([numLeftConstraint, numTopConstraint])
        
    }
}
