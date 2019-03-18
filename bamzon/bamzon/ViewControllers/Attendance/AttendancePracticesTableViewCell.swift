//
//  AttendancePracticesTableViewCell.swift
//  bamzon
//
//  Created by Kyle Vu on 3/13/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

// Table View cell for "Previous Practices"
class AttendancePracticesTableViewCell: UITableViewCell {

    var practiceDate = UILabel()
    var attendancePercentage = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "TSTeal")
        
        practiceDate = createLabelToConstrain(withText: "mm/dd/yyyy", alignment: .left, boldType: "", fontSize: 20, numLines: 1, hasScaleFactor: true)
        
        addSubviews()
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(practiceDate)
    }
    
    func setupAutoLayout() {
        //        //image constraints
        //        let imgLeftConstraint = imgUser.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        //        let imgVertConstraint = imgUser.topAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -35)
        //        let imgWidthConstraint = imgUser.widthAnchor.constraint(equalToConstant: 70)
        //        let imgHeightConstraint = imgUser.heightAnchor.constraint(equalToConstant: 70)
        //        self.contentView.addConstraints([imgLeftConstraint, imgVertConstraint, imgWidthConstraint, imgHeightConstraint])
        
        // Date Label constraints
        let dateLeftConstraint = practiceDate.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10)
        let dateTopConstraint = practiceDate.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        let dateWidthConstraint = practiceDate.leadingAnchor.constraint(lessThanOrEqualTo: self.contentView.centerXAnchor)
        self.contentView.addConstraints([dateLeftConstraint, dateTopConstraint, dateWidthConstraint])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
