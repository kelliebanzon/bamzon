//
//  PlayersAttendanceTableViewCell.swift
//  bamzon
//
//  Created by Kyle Vu on 3/12/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class PlayersAttendanceTableViewCell: UITableViewCell {

    var userName = UILabel()
    var attendanceType = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "TSTeal")
        
        userName = createLabelToConstrain(withText: "Last, First", alignment: .left, boldType: "", fontSize: 20, numLines: 1, hasScaleFactor: true)
        
        addSubviews()
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(userName)
    }
    
    func setupAutoLayout() {
//        //image constraints
//        let imgLeftConstraint = imgUser.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
//        let imgVertConstraint = imgUser.topAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -35)
//        let imgWidthConstraint = imgUser.widthAnchor.constraint(equalToConstant: 70)
//        let imgHeightConstraint = imgUser.heightAnchor.constraint(equalToConstant: 70)
//        self.contentView.addConstraints([imgLeftConstraint, imgVertConstraint, imgWidthConstraint, imgHeightConstraint])
        
        //name constraints
        let nameLeftConstraint = userName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        let nameTopConstraint = userName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        let nameWidthConstraint = userName.leadingAnchor.constraint(lessThanOrEqualTo: self.contentView.centerXAnchor)
        self.contentView.addConstraints([nameLeftConstraint, nameTopConstraint, nameWidthConstraint])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
