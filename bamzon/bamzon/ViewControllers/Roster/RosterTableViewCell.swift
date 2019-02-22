//
//  RosterTableViewCell.swift
//  bamzon
//
//  Created by Brandon Ryan on 21.02.19.
//  Copyright © 2019 bamzon. All rights reserved.
//
import Foundation
import UIKit

class RosterTableViewCell: UITableViewCell {
    
    var userName = UILabel()
    var imgUser = UIImageView()
    var userNumber = UILabel()
    var userEmail = UILabel()
    var userYear = UILabel()
    var userRole = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "TSTeal")
        
        imgUser = {
            let pic = UIImageView()
            pic.contentMode = .scaleAspectFill
            pic.clipsToBounds = true
            pic.image = UIImage(named: "BZN-Square-Logo")
            pic.layer.cornerRadius = 35
            pic.translatesAutoresizingMaskIntoConstraints = false
            return pic
        }()
        
        userName = createLabelToConstrain(withText: "Last, First", alignment: .left, boldType: "-Bold", fontSize: 20, numLines: 1, hasScaleFactor: true)
        
        userNumber = createLabelToConstrain(withText: "420-666-6969", alignment: .left, boldType: "", fontSize: 17, numLines: 0, hasScaleFactor: false)
        
        userEmail = createLabelToConstrain(withText: "willywonka@chocolate.com", alignment: .left, boldType: "", fontSize: 17, numLines: 1, hasScaleFactor: true)
        
        userYear = createLabelToConstrain(withText: "3", alignment: .left, boldType: "-Bold", fontSize: 17, numLines: 1, hasScaleFactor: false)
        
        userRole = createLabelToConstrain(withText: "Member", alignment: .left, boldType: "", fontSize: 17, numLines: 1, hasScaleFactor: false)

        addSubviews()
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(userName)
        contentView.addSubview(imgUser)
        contentView.addSubview(userNumber)
        contentView.addSubview(userEmail)
        contentView.addSubview(userYear)
        contentView.addSubview(userRole)
    }
    
    func setupAutoLayout() {
        //image constraints
        let imgLeftConstraint = imgUser.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        let imgVertConstraint = imgUser.topAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -35)
        let imgWidthConstraint = imgUser.widthAnchor.constraint(equalToConstant: 70)
        let imgHeightConstraint = imgUser.heightAnchor.constraint(equalToConstant: 70)
        self.contentView.addConstraints([imgLeftConstraint, imgVertConstraint, imgWidthConstraint, imgHeightConstraint])
        
        //name constraints
        let nameLeftConstraint = userName.leadingAnchor.constraint(equalTo: imgUser.trailingAnchor, constant: 15)
        let nameTopConstraint = userName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        let nameWidthConstraint = userName.widthAnchor.constraint(equalToConstant: 100)
        self.contentView.addConstraints([nameLeftConstraint, nameTopConstraint, nameWidthConstraint])
        
        //number constraints
        let numLeftConstraint = userNumber.leadingAnchor.constraint(equalTo: imgUser.trailingAnchor, constant: 15)
        let numTopConstraint = userNumber.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 5)
        self.contentView.addConstraints([numLeftConstraint, numTopConstraint])
        
        //email constraints
        let emailLeftConstraint = userEmail.leadingAnchor.constraint(equalTo: imgUser.trailingAnchor, constant: 15)
        let emailTopConstraint = userEmail.topAnchor.constraint(equalTo: userNumber.bottomAnchor, constant: 5)
        let emailRightConstraint = self.contentView.trailingAnchor.constraint(equalTo: userEmail.trailingAnchor, constant: 20)
        self.contentView.addConstraints([emailLeftConstraint, emailTopConstraint, emailRightConstraint])
        
        //year constraints
        let yearRightConstraint = self.contentView.trailingAnchor.constraint(equalTo: userYear.trailingAnchor, constant: 15)
        let yearTopConstraint = userYear.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        self.contentView.addConstraints([yearRightConstraint, yearTopConstraint])
        
        //role constraints
        let roleRightConstraint = self.contentView.trailingAnchor.constraint(equalTo: userRole.trailingAnchor, constant: 15)
        let roleTopConstraint = userRole.topAnchor.constraint(equalTo: userYear.bottomAnchor, constant: 5)
        self.contentView.addConstraints([roleRightConstraint, roleTopConstraint])
    }
}
