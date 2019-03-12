//
//  EventTableViewCellVC.swift
//  bamzon
//
//  Created by Brandon Ryan on 05.03.19.
//  Copyright © 2019 bamzon. All rights reserved.
//
import UIKit

class EventTableViewCellVC: UITableViewCell {
    
    var rsvpTypeLabel = UILabel()
    var rsvpsLabel = UILabel()
    var carrotLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "TSTeal")
        
        rsvpTypeLabel = createLabelToConstrain(withText: "Rsvp Type", alignment: .left, boldType: "", fontSize: 17, numLines: 1, hasScaleFactor: true)
        
        rsvpsLabel = createLabelToConstrain(withText: "X", alignment: .right, boldType: "-Medium", fontSize: 17, numLines: 1, hasScaleFactor: true)
        
        carrotLabel = createLabelToConstrain(withText: ">", alignment: .left, boldType: "-Bold", fontSize: 19, numLines: 0, hasScaleFactor: false)
        
        addSubviews()
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.contentView.addSubview(rsvpTypeLabel)
        self.contentView.addSubview(rsvpsLabel)
        self.contentView.addSubview(carrotLabel)
    }
    
    func setupAutoLayout() {
        
        //rsvp type label constraints
        let rsvpTypeLeftConstraint = rsvpTypeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
        //let rsvpTypeRightConstraint = rsvpsLabel.leadingAnchor.constraint(greaterThanOrEqualTo: rsvpTypeLabel.trailingAnchor, constant: 20)
        let rsvpTypeTopConstraint = rsvpTypeLabel.bottomAnchor.constraint(equalTo: rsvpsLabel.bottomAnchor)
        self.contentView.addConstraints([rsvpTypeLeftConstraint, rsvpTypeTopConstraint])
        
        //rsvp constraints
        let rsvpRightConstraint = self.contentView.trailingAnchor.constraint(greaterThanOrEqualTo: rsvpsLabel.trailingAnchor, constant: 100)
        let rsvpTopConstraint = rsvpsLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        let rsvpLeftConstraint = rsvpsLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 100)
        self.contentView.addConstraints([rsvpRightConstraint, rsvpTopConstraint, rsvpLeftConstraint])
        
        //carrot constraints
        let carrotRightConstraint = self.contentView.trailingAnchor.constraint(equalTo: carrotLabel.trailingAnchor, constant: 20)
        let carrotTopConstraint = carrotLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        self.contentView.addConstraints([carrotTopConstraint, carrotRightConstraint])

    }
}
