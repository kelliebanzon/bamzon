//
//  CalendarVCTableViewCell.swift
//  bamzon
//
//  Created by Brandon Ryan on 12.03.19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class CalendarVCTableViewCell: UITableViewCell {
    
    var columnDividerOne = CAShapeLayer()
    var columnDividerTwo = CAShapeLayer()
    var eventLabel = UILabel()
    var dateLabel = UILabel()
    var locLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "TSTeal")
        
        columnDividerOne.path = UIBezierPath(roundedRect: CGRect(x: self.contentView.frame.width * (2/5), y: 0, width: 1, height: 70), cornerRadius: 8).cgPath
        columnDividerOne.fillColor = UIColor.white.cgColor
        
        columnDividerTwo.path = UIBezierPath(roundedRect: CGRect(x: self.contentView.frame.width * (4/5), y: 0, width: 1, height: 70), cornerRadius: 8).cgPath
        columnDividerTwo.fillColor = UIColor.white.cgColor
        
        eventLabel = createLabelToConstrain(withText: "event_info", alignment: .left, boldType: "", fontSize: 17, numLines: 3, hasScaleFactor: true)
        dateLabel = createLabelToConstrain(withText: "date_info", alignment: .left, boldType: "", fontSize: 17, numLines: 3, hasScaleFactor: true)
        locLabel = createLabelToConstrain(withText: "loc_info", alignment: .left, boldType: "", fontSize: 17, numLines: 3, hasScaleFactor: true)
        
        addSubviews()
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.contentView.layer.addSublayer(columnDividerOne)
        self.contentView.layer.addSublayer(columnDividerTwo)
        self.contentView.addSubview(eventLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(locLabel)
    }
    
    func setupAutoLayout() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        let dateLeftConstraint = dateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: self.contentView.frame.width * 2/5 + 5)
        let dateRightConstraint = dateLabel.trailingAnchor.constraint(greaterThanOrEqualTo: dateLabel.trailingAnchor, constant: self.contentView.frame.width * 1/5)
        self.contentView.addConstraints([dateLeftConstraint, dateRightConstraint])
        
        locLabel.translatesAutoresizingMaskIntoConstraints = false
        let locRightConstraint = locLabel.trailingAnchor.constraint(equalTo:
            self.contentView.trailingAnchor, constant: -5)
        let locLeftContraint = locLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: self.contentView.frame.width * 1/5)
        self.contentView.addConstraints([locRightConstraint, locLeftContraint])
        
        eventLabel.translatesAutoresizingMaskIntoConstraints = false
        let eventLeftConstraint = eventLabel.leadingAnchor.constraint(equalTo:
            self.contentView.leadingAnchor, constant: 5)
        let eventRightConstraint = eventLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -5)
        self.contentView.addConstraints([eventLeftConstraint, eventRightConstraint])
    }
}
