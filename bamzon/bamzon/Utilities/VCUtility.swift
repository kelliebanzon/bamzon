//
//  VCUtility.swift
//  bamzon
//
//  Created by Kevin Krein on 2/10/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import UIKit

class VCUtility {
    let header1Font = UIFont(name: "HelveticaNeue-Bold", size: 30)
    let header2Font = UIFont(name: "HelveticaNeue-Bold", size: 16)
    let header3Font = UIFont(name: "HelveticaNeue-Bold", size: 14)
    let bodyFont = UIFont(name: "HelveticaNeue-Medium", size: 12)
}

extension UIViewController {
    
    func setRootView(toVC: String) {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: toVC)
        // swiftlint:disable force_cast
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // swiftlint:enable force_cast
        appDelegate.hideTabController()
        appDelegate.window?.rootViewController = nextVC
        UIView.transition(with: appDelegate.window!, duration: 0.75, options: UIViewAnimationOptions.transitionFlipFromRight, animations: { appDelegate.window?.rootViewController = nextVC}, completion: nil)
    }

    func createDefaultNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.barStyle = .black
        navController.navigationBar.barTintColor = UIColor(named: "TSNavy")
        navController.navigationBar.isTranslucent = true
        navController.navigationBar.tintColor = .white
        let backButton = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "arrow-left")))
        self.navigationItem.backBarButtonItem = backButton
        return navController
    }

    func mockSegue(toIdentifier: String) {
        //let nextVC = self.storyboard!.instantiateViewController(withIdentifier: toIdentifier)
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: toIdentifier)
        self.present(nextVC, animated: true, completion: nil)
    }
    
    func mockSegue(toVC: UIViewController) {
        self.present(toVC, animated: true, completion: nil)
    }

    @available(*, deprecated, message: "VCs will be named in the Nav Controller. If you need a header label, use createDefaultHeader1Label()")
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

    func createBackButtonArrow(button: UIButton) -> UIButton {
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        button.tintColor = .white
        button.showsTouchWhenHighlighted = true
//        if let action = action {
//            button.addTarget(self, action: #selector(action), for: .touchUpInside)
//        }
        return button
    }

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

    func createDefaultHeader1Label(text: String, numLines: Int = 1, fontColor: UIColor = .white, fontAlignment: NSTextAlignment = .left) -> UILabel {
        return createDefaultLabel(text: text, fontSize: 30, numLines: numLines, fontColor: fontColor, fontAlignment: fontAlignment)
    }

    func createDefaultHeader2Label(text: String, numLines: Int = 1, fontColor: UIColor = .white, fontAlignment: NSTextAlignment = .left) -> UILabel {
        return createDefaultLabel(text: text, fontSize: 25, numLines: numLines, fontColor: fontColor, fontAlignment: fontAlignment)
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
    
    func createDefaultTextButton(withText: String, withAction: Selector?, withFrame: CGRect?, withCenter: CGPoint?, withNumLines: Int?) -> UIButton {
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

    func createProfilePictureImageView(imageName: String?) -> UIImageView {
        let profilePictureImageView = UIImageView()
        profilePictureImageView.contentMode = .scaleAspectFill
        profilePictureImageView.clipsToBounds = true
        profilePictureImageView.image = UIImage(named: imageName ?? "default-profile-picture")
        //profilePictureImageView.roundCorners()
        return profilePictureImageView
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

var vSpinner : UIView?
extension UIViewController {
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
