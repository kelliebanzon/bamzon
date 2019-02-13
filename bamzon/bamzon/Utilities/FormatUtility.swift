//
//  FormatUtility.swift
//  bamzon
//
//  Created by Kevin Krein on 2/10/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FormatUtility {
    
    //Center and frame must be set outside of this function
    static func createDefaultButton(withText: String, withFrame: CGRect?, withCenter: CGPoint?) -> UIButton{
        let button : UIButton
        if let frame = withFrame {
            button = UIButton(frame: frame)
        } else {
            button = UIButton()
        }
        if let center = withCenter {
            button.center = center
        }
        button.setTitle(withText, for: .normal)
        button.backgroundColor = UIColor(named: "TSYellow")
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 1.0
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        button.addTarget(self, action: #selector(FormatUtility.highlightButton), for: .touchDown)
        button.addTarget(self, action: #selector(FormatUtility.unhighlightButton), for: [.touchUpOutside, .touchUpInside])
        return button
    }
    
    // Highlight the button upon touchDown
    @objc static func highlightButton(sender: UIButton!) {
        sender.backgroundColor = UIColor(named: "TSYellowDark")
    }

    // Unhighlight the button upon touchDown
    @objc static func unhighlightButton(sender: UIButton!) {
        sender.backgroundColor = UIColor(named: "TSYellow")
    }
}
