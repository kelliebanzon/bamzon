//
//  StatsPlayerStatsTableViewCell.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/22/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class StatsPlayerStatsTableViewCell: UITableViewCell {

    var eventName: String?
    var valueText: String?
    var eventLabel = UILabel()
    var valueLabel = UILabel()

    let formatUtil = FormatUtility()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        display()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        display()
    }

    func display() {
        contentView.backgroundColor = UIColor(named: "TSTeal")

        eventLabel = createDefaultBoldLabel(text: eventName ?? "")
        contentView.addSubview(eventLabel)

        valueLabel = createDefaultBodyLabel(text: valueText ?? "", fontAlignment: .right)
        contentView.addSubview(valueLabel)

        setupAutoLayout()
    }

    func setupAutoLayout() {
        let margins = contentView.safeAreaLayoutGuide

        eventLabel.translatesAutoresizingMaskIntoConstraints = false
        let eventLabelVert = eventLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor)
        let eventLabelLeading = eventLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10)
        let eventLabelTrailing = eventLabel.trailingAnchor.constraint(greaterThanOrEqualTo: valueLabel.leadingAnchor, constant: 10)
        addConstraints([eventLabelVert, eventLabelLeading, eventLabelTrailing])

        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        let valueLabelVert = valueLabel.centerYAnchor.constraint(equalTo: eventLabel.centerYAnchor)
        let valueLabelTrailing = margins.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor, constant: 10)
        addConstraints([valueLabelVert, valueLabelTrailing])
    }

}
