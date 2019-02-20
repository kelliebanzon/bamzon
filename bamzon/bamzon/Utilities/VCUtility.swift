//
//  VCUtility.swift
//  bamzon
//
//  Created by Kevin Krein on 2/10/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func mockSegue(toIdentifier: String) {
        let nextVC = self.storyboard!.instantiateViewController(withIdentifier: toIdentifier)
        self.present(nextVC, animated: true, completion: nil)
    }
    
    func mockSegue(toVC: UIViewController) {
        self.present(toVC, animated: true, completion: nil)
    }
    
    func pageLabel(withText: String, withFrame: CGRect?, withCenter: CGPoint?) -> UILabel {
        let pageLabel: UILabel
        if let frame = withFrame {
            pageLabel = UILabel(frame: frame)
        } else {
            pageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 120))
        }
        if let center = withCenter {
            pageLabel.center = center
        } else {
            pageLabel.center = CGPoint(x: view.frame.midX, y: 150)
        }
        pageLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        pageLabel.textAlignment = .center
        pageLabel.numberOfLines = 0
        pageLabel.textColor = .white
        pageLabel.text = withText
        return pageLabel
    }
    
    func alert(withTitle: String, withMessage: String) {
        let alert = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    //Center and frame must be set outside of this function
    func createDefaultButton(withText: String, withFrame: CGRect?, withAction: Selector?, withCenter: CGPoint?) -> UIButton {
        let button: UIButton
        if let frame = withFrame {
            button = UIButton(frame: frame)
        } else {
            button = UIButton()
        }
        if let action = withAction {
            button.addTarget(self, action: action, for: .touchUpInside)
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
        button.addTarget(self, action: #selector(highlightButton), for: .touchDown)
        button.addTarget(self, action: #selector(unhighlightButton), for: [.touchUpOutside, .touchUpInside])
        return button
    }
    
    func createDefaultTextField(withText: String, withFrame: CGRect?, withCenter: CGPoint?, withPadding: CGRect?) -> UITextField {
        let textField: UITextField
        let frame: CGRect
        let defaultTextFieldPadding = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        
        if let inputFrame = withFrame {
            frame = inputFrame
        } else {
            frame = CGRect(x: 20, y: 240, width: 340, height: 35)
        }
        
        textField = UITextField(frame: frame)
        
        if let padding = withPadding {
            textField.leftView = UIView(frame: padding)
        } else {
            textField.leftView = defaultTextFieldPadding
        }
        
        if let center = withCenter {
            textField.center = center
        }
        
        /*let bar = createTextFieldBar(withRect: CGRect(x: textField.center.x-textField.frame.width/2, y: textField.center.y+textField.frame.height/2, width: textField.frame.width, height: 2))
        print(textField.frame)
        self.view.layer.addSublayer(bar)*/
        
        textField.leftViewMode = .always
        textField.attributedPlaceholder = NSAttributedString(string: withText, attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSWhite75")!])
        textField.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        textField.textColor = .white
        
        return textField
    }
    
    func defaultTextButton(withText: String, withAction: Selector?, withFrame: CGRect?, withCenter: CGPoint?, withNumLines: Int?) -> UIButton {
        let textButton: UIButton
        
        if let frame = withFrame {
            textButton = UIButton(frame: frame)
        } else {
            textButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        }
        if let numLines = withNumLines {
            textButton.titleLabel?.numberOfLines = numLines
        } else {
            textButton.titleLabel?.numberOfLines = 1
        }
        if let center = withCenter {
            textButton.center = center
        }
        
        if let action = withAction {
            textButton.addTarget(self, action: action, for: .touchUpInside)
        }
        
        let attributedString = NSAttributedString(
            string: NSLocalizedString(withText, comment: ""),
            attributes: [
                NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Medium", size: 20)!,
                NSAttributedStringKey.foregroundColor: UIColor.white,
                NSAttributedStringKey.underlineStyle: 1.0
            ])
        textButton.titleLabel?.adjustsFontSizeToFitWidth = true
        textButton.titleLabel?.textAlignment = .center
        
        textButton.setAttributedTitle(attributedString, for: .normal)
        
        return textButton
    }
    
    func createTextFieldBar(withRect: CGRect) -> CAShapeLayer {
        let bar = CAShapeLayer()
        bar.path = UIBezierPath(roundedRect: withRect, cornerRadius: 8).cgPath
        bar.fillColor = UIColor.white.cgColor
        return bar
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
