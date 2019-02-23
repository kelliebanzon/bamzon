//
//  StatsPlayerStatsTableViewCell.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/22/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class StatsPlayerStatsTableViewCell: UITableViewCell {

    var eventLabel = UILabel()
    var prLabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        display()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        display()
    }

    func display() {
        eventLabel = createTableLabel(numLines: 2)
        addSubview(eventLabel)

        prLabel = createTableLabel(numLines: 2)
        addSubview(prLabel)

        setupAutoLayout()
    }

    func setupAutoLayout() {
        eventLabel.translatesAutoresizingMaskIntoConstraints = false
        let eventLabelVert = eventLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        let eventLabelLeading = eventLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        let eventLabelTrailing = eventLabel.trailingAnchor.constraint(greaterThanOrEqualTo: prLabel.leadingAnchor, constant: 12)
        addConstraints([eventLabelVert, eventLabelLeading, eventLabelTrailing])

        prLabel.translatesAutoresizingMaskIntoConstraints = false
        let prLabelVert = prLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        let prLabelLeading = prLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.width / 2 + 12)
        let prLabelTrailing = trailingAnchor.constraint(equalTo: prLabel.trailingAnchor, constant: 12)
        addConstraints([prLabelVert, prLabelLeading, prLabelTrailing])
    }

}
