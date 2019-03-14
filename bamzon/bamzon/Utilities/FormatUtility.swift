//
//  FormatUtility.swift
//  bamzon
//
//  Created by Kellie Banzon on 03/13/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit

class FormatUtility {

    func createDefaultLabel(text: String, fontSize: CGFloat = 15, numLines: Int = 1, fontColor: UIColor = .white, fontAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: fontSize)
        label.numberOfLines = numLines
        label.textColor = fontColor
        label.textAlignment = fontAlignment
        label.text = text
        label.minimumScaleFactor = 0.8
        label.adjustsFontSizeToFitWidth = true
        return label
    }

    func createDefaultBoldLabel(text: String, numLines: Int = 1, fontColor: UIColor = .white, fontAlignment: NSTextAlignment = .left) -> UILabel {
        let label = createDefaultLabel(text: text, fontSize: 20, numLines: numLines, fontColor: fontColor, fontAlignment: fontAlignment)
        return label
    }

    func createDefaultBodyLabel(text: String, numLines: Int = 1, fontColor: UIColor = .white, fontAlignment: NSTextAlignment = .left) -> UILabel {
        let label = createDefaultLabel(text: text, numLines: numLines, fontColor: fontColor, fontAlignment: fontAlignment)
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        return label
    }

}
