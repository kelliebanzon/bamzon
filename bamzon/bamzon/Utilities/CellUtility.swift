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

    func createDefaultBoldLabel(text: String, numLines: Int = 1, fontColor: UIColor = .white, fontAlignment: NSTextAlignment = .left) -> UILabel {
        let label = FormatUtility().createDefaultLabel(text: text, fontSize: 16, numLines: numLines, fontColor: fontColor, fontAlignment: fontAlignment)
        return label
    }

    func createDefaultBodyLabel(text: String, numLines: Int = 1, fontColor: UIColor = .white, fontAlignment: NSTextAlignment = .left) -> UILabel {
        let label = FormatUtility().createDefaultLabel(text: text, numLines: numLines, fontColor: fontColor, fontAlignment: fontAlignment)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        return label
    }

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

    func highlightYellowOnSelection() {
        let cellBackgroundView = UIView()
        cellBackgroundView.backgroundColor = UIColor(named: "TSYellow")
        self.selectedBackgroundView = cellBackgroundView
    }

    func createButtonToConstrain(withText: String, size: CGFloat) -> UIButton {
        let button = UIButton()
        button.setTitle("\(withText)", for: .normal)
        button.backgroundColor = UIColor(named: "TSYellow")
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 1.0
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: size)
        button.addTarget(self, action: #selector(highlightButton), for: .touchDown)
        button.addTarget(self, action: #selector(unhighlightButton), for: [.touchUpOutside, .touchUpInside])
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    // Highlight the button upon touchDown
    @objc func highlightButton(sender: UIButton!) {
        sender.backgroundColor = UIColor(named: "TSYellowDark")
    }
    
    // Unhighlight the button upon touchDown
    @objc func unhighlightButton(sender: UIButton!) {
        sender.backgroundColor = UIColor(named: "TSYellow")
    }
}
