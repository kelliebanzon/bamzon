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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "TSTeal")
        
        columnDividerOne.path = UIBezierPath(roundedRect: CGRect(x: self.contentView.frame.width * (2/5), y: 0, width: 1, height: 70), cornerRadius: 8).cgPath
        columnDividerOne.fillColor = UIColor.white.cgColor
        
        columnDividerTwo.path = UIBezierPath(roundedRect: CGRect(x: self.contentView.frame.width * (4/5), y: 0, width: 1, height: 70), cornerRadius: 8).cgPath
        columnDividerTwo.fillColor = UIColor.white.cgColor
        
        addSubviews()
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews(){
        self.contentView.layer.addSublayer(columnDividerOne)
        self.contentView.layer.addSublayer(columnDividerTwo)
    }
    
    func setupAutoLayout(){
        
    }
}
