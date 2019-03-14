//
//  StatsOtherPlayerNamesTableViewCell.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/26/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class StatsOtherPlayerNamesTableViewCell: UITableViewCell, DisplayableProtocol {

    var nameLabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        display()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func display() {
        contentView.backgroundColor = UIColor(named: "TSTeal")

        nameLabel = createDefaultBoldLabel(text: "")
        addSubview(nameLabel)
        
        setupAutoLayout()
    }

    func setupAutoLayout() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let nameLabelVert = nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        let nameLabelLeading = nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        let nameLabelTrailing = trailingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 12)
        addConstraints([nameLabelVert, nameLabelLeading, nameLabelTrailing])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        display()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
