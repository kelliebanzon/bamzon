//
//  PlayersAttendanceTableViewCell.swift
//  bamzon
//
//  Created by Kyle Vu on 3/12/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

// Table View Cell for "Today's Practice"
class CurrentAttendanceTableViewCell: UITableViewCell {

    var userName = UILabel()
    var attendanceType = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "TSTeal")
        
        userName = createLabelToConstrain(withText: "Last, First", alignment: .left, boldType: "", fontSize: 20, numLines: 1, hasScaleFactor: true)
        
        attendanceType = createButtonToConstrain(withText: "Absent", size: 12)
        
        addSubviews()
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(userName)
        contentView.addSubview(attendanceType)
    }
    
    @objc func changeAttendanceType() {
        print("Do something with this button")
    }
    
    func setupAutoLayout() {
        //name constraints
        let nameLeftConstraint = userName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        let nameTopConstraint = userName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        let nameWidthConstraint = userName.leadingAnchor.constraint(lessThanOrEqualTo: self.contentView.centerXAnchor)
        self.contentView.addConstraints([nameLeftConstraint, nameTopConstraint, nameWidthConstraint])
        
        // Attendance button constraints
        let attendanceLeftConstraint = attendanceType.leadingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -80)
        let attendanceTopConstraint = attendanceType.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        let attendanceWidthConstraint = attendanceType.widthAnchor.constraint(equalToConstant: 50)
        self.contentView.addConstraints([attendanceLeftConstraint, attendanceTopConstraint, attendanceWidthConstraint])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
