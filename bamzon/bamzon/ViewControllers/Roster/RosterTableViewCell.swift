//
//  RosterTableViewCell.swift
//  bamzon
//
//  Created by Brandon Ryan on 21.02.19.
//  Copyright © 2019 bamzon. All rights reserved.
//
import UIKit

class RosterTableViewCell: UITableViewCell {
    
    var userName = UILabel()
    var imgUserName: String? = nil
    var imgUser = UIImageView()
    var userNumber = UILabel()
    var userEmail = UILabel()
    var userYear = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "TSTeal")
        
        imgUser = ImageUtility().createProfilePictureImageView(imageName: imgUserName, style: .squircle)
        
        userName = createLabelToConstrain(withText: "Last, First", alignment: .left, boldType: "-Bold", fontSize: 20, numLines: 1, hasScaleFactor: true)
        
        userNumber = createLabelToConstrain(withText: "420-666-6969", alignment: .left, boldType: "", fontSize: 17, numLines: 0, hasScaleFactor: false)
        
        userEmail = createLabelToConstrain(withText: "example@email.com", alignment: .left, boldType: "", fontSize: 17, numLines: 1, hasScaleFactor: true)
        
        userYear = createLabelToConstrain(withText: "X", alignment: .left, boldType: "-Bold", fontSize: 17, numLines: 1, hasScaleFactor: false)

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
    }
    
    func setupAutoLayout() {
        let margins = contentView.safeAreaLayoutGuide

        imgUser.translatesAutoresizingMaskIntoConstraints = false
        let imgLeadingConstraint = imgUser.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10)
        let imgTopConstraint = imgUser.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10)
        let imgBottomConstraint = margins.bottomAnchor.constraint(equalTo: imgUser.bottomAnchor, constant: 10)
        let imgAspectConstraint = imgUser.widthAnchor.constraint(equalTo: imgUser.heightAnchor)
        self.contentView.addConstraints([imgLeadingConstraint, imgTopConstraint, imgBottomConstraint, imgAspectConstraint])
        
        userYear.translatesAutoresizingMaskIntoConstraints = false
        let yearRightConstraint = margins.trailingAnchor.constraint(equalTo: userYear.trailingAnchor, constant: 15)
        let yearTopConstraint = userYear.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10)
        self.contentView.addConstraints([yearRightConstraint, yearTopConstraint])
        
        userName.translatesAutoresizingMaskIntoConstraints = false
        let nameLeftConstraint = userName.leadingAnchor.constraint(equalTo: imgUser.trailingAnchor, constant: 15)
        let nameTopConstraint = userName.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10)
        let nameWidthConstraint = userYear.leadingAnchor.constraint(greaterThanOrEqualTo: userName.trailingAnchor, constant: 20)
        self.contentView.addConstraints([nameLeftConstraint, nameTopConstraint, nameWidthConstraint])
        
        userNumber.translatesAutoresizingMaskIntoConstraints = false
        let numLeftConstraint = userNumber.leadingAnchor.constraint(equalTo: imgUser.trailingAnchor, constant: 15)
        let numTopConstraint = userNumber.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 5)
        self.contentView.addConstraints([numLeftConstraint, numTopConstraint])
        
        userEmail.translatesAutoresizingMaskIntoConstraints = false
        let emailLeftConstraint = userEmail.leadingAnchor.constraint(equalTo: imgUser.trailingAnchor, constant: 15)
        let emailTopConstraint = userEmail.topAnchor.constraint(equalTo: userNumber.bottomAnchor, constant: 5)
        let emailRightConstraint = margins.trailingAnchor.constraint(equalTo: userEmail.trailingAnchor, constant: 20)
        self.contentView.addConstraints([emailLeftConstraint, emailTopConstraint, emailRightConstraint])
    }
}
