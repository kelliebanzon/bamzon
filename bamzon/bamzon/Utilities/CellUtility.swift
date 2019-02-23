//
//  CellUtility.swift
//  bamzon
//
//  Created by Brandon Ryan on 21.02.19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {

    func createTableLabel(numLines: Int = 1) -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = numLines
        label.minimumScaleFactor = 0.8
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    // TODO: these definitions probably collide
    func createLabelToConstrain(withText: String, alignment: NSTextAlignment, boldType: String, fontSize: CGFloat, numLines: Int, hasScaleFactor: Bool) -> UILabel {
        let label: UILabel = UILabel()
        label.textAlignment = alignment
        label.text = withText
        label.font = UIFont(name: "HelveticaNeue\(boldType)", size: fontSize)
        label.numberOfLines = numLines
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        if hasScaleFactor {
            label.minimumScaleFactor = 0.25
            label.adjustsFontSizeToFitWidth = true
        }
        return label
    }
}
