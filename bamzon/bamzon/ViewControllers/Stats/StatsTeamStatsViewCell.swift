//
//  StatsTeamStatsViewCell.swift
//  bamzon
//
//  Created by Brandon Ryan on 25.02.19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class StatsTeamStatsViewCell: UITableViewCell {
    
    var statsDescLabel = UILabel()
    var statsLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "TSTeal")
        
        statsDescLabel = createLabelToConstrain(withText: "Stat Type", alignment: .left, boldType: "", fontSize: 17, numLines: 1, hasScaleFactor: true)
        
        statsLabel = createLabelToConstrain(withText: "X", alignment: .right, boldType: "-Medium", fontSize: 17, numLines: 1, hasScaleFactor: true)

        addSubviews()
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.contentView.addSubview(statsDescLabel)
        self.contentView.addSubview(statsLabel)
    }

    func setupAutoLayout() {
        
        //stat constraints
        let statRightConstraint = self.contentView.trailingAnchor.constraint(equalTo: statsLabel.trailingAnchor, constant: 20)
        let statTopConstraint = statsLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        self.contentView.addConstraints([statRightConstraint, statTopConstraint])
        
        //desc label constraints
        let statDescLeftConstraint = statsDescLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
        let statDescRightConstraint = statsLabel.leadingAnchor.constraint(greaterThanOrEqualTo: statsDescLabel.trailingAnchor, constant: 20)
        let statDescTopConstraint = statsDescLabel.bottomAnchor.constraint(equalTo: statsLabel.bottomAnchor)
        self.contentView.addConstraints([statDescLeftConstraint, statDescRightConstraint, statDescTopConstraint])
        
    }
}
