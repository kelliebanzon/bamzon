//
//  AttendancePlayerTVCell.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/20/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit


class AttendancePlayerTableViewCell: UITableViewCell, DisplayableProtocol {

    var nameLabel = UILabel()
    var dateLabel = UILabel()
    var locationLabel = UILabel()

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
        nameLabel = createTableLabel()
        addSubview(nameLabel)

        dateLabel = createTableLabel()
        addSubview(dateLabel)

        locationLabel = createTableLabel()
        addSubview(locationLabel)

        setupAutoLayout()
    }

    func setupAutoLayout() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        let nameLabelVert = nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        let nameLabelLeading = nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        let nameLabelTrailing = nameLabel.trailingAnchor.constraint(greaterThanOrEqualTo: dateLabel.leadingAnchor, constant: 12)
        addConstraints([nameLabelVert, nameLabelLeading, nameLabelTrailing])

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        let dateLabelVert = dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        let dateLabelLeading = dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90)
        let dateLabelTrailing = locationLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 12)
        addConstraints([dateLabelVert, dateLabelLeading, dateLabelTrailing])

        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        let locationLabelVert = locationLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        let locationLabelLeading = locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 200)
        let locationLabelTrailing = trailingAnchor.constraint(equalTo: locationLabel.trailingAnchor)
        addConstraints([locationLabelVert, locationLabelLeading, locationLabelTrailing])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
