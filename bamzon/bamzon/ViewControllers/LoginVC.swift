//
//  LoginVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class LoginVC: UIViewController, DisplayableProtocol, UITextFieldDelegate {
    
    var email: UITextField?
    var password: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        display()
    }
    
    func display() {
        // TODO: implement display
        view.backgroundColor = UIColor(named: "TSTeal")
        
        let emailPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        let passwordPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
   
        //Top label
        let topLabel = UILabel()
        topLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        topLabel.numberOfLines = 0
        topLabel.textColor = .white
        topLabel.textAlignment = .center
        topLabel.text = "Sign in with your TeamSync credentials"
        self.view.addSubview(topLabel)
        
        //Top label constraints
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        let horizLabelConstraint = topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertLabelConstraint = topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80)
        let leftLabelConstraint = topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        //Why is this one switched? view first instead of topLabel?
        let rightLabelConstraint = view.trailingAnchor.constraint(equalTo: topLabel.trailingAnchor, constant: 20)
        self.view.addConstraints([horizLabelConstraint, vertLabelConstraint, leftLabelConstraint, rightLabelConstraint])

        //Email
        
        //Email Text Field
        email = UITextField()
        email?.leftView = emailPaddingView
        email?.leftViewMode = .always
        email?.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSWhite75")!])
        email?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        email?.textColor = .white
        email?.autocapitalizationType = UITextAutocapitalizationType(rawValue: 0)!
        email?.autocorrectionType = UITextAutocorrectionType(rawValue: 0)!
        email?.delegate = self
        self.view.addSubview(email!)
        
        //Email Text Field constraints
        email?.translatesAutoresizingMaskIntoConstraints = false
        let horizEmailConstraint = email?.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertEmailConstraint = email?.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 50)
        let leftEmailConstraint = email?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let rightEmailConstraint = view.trailingAnchor.constraint(equalTo: (email?.trailingAnchor)!, constant: 20)
        self.view.addConstraints([horizEmailConstraint!, vertEmailConstraint!, leftEmailConstraint!, rightEmailConstraint])
        
        //Email Bar
        /*let nameBar = CAShapeLayer()
        nameBar.path = UIBezierPath(roundedRect: CGRect(x: , y: , width: view.frame.width - 40, height: 2), cornerRadius: 8).cgPath
        nameBar.fillColor = UIColor.white.cgColor
        self.view.layer.addSublayer(nameBar)*/
        
        //Password Text Field
        password = UITextField()
        password?.leftView = passwordPaddingView
        password?.leftViewMode = .always
        password?.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSWhite75")!])
        password?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        password?.textColor = .white
        password?.isSecureTextEntry = true
        self.view.addSubview(password!)
        
        //Email Text Field constraints
        password?.translatesAutoresizingMaskIntoConstraints = false
        let horizPassConstraint = password?.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertPassConstraint = password?.topAnchor.constraint(equalTo: email!.bottomAnchor, constant: 60)
        let leftPassConstraint = password?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let rightPassConstraint = view.trailingAnchor.constraint(equalTo: (password?.trailingAnchor)!, constant: 20)
        self.view.addConstraints([horizPassConstraint!, vertPassConstraint!, leftPassConstraint!, rightPassConstraint])
        
        //Buttons
        
        //loginButton
        let loginButton = UIButton()
        loginButton.setTitle("Log in", for: .normal)
        loginButton.backgroundColor = UIColor(named: "TSYellow")
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        loginButton.layer.masksToBounds = false
        loginButton.layer.shadowRadius = 1.0
        loginButton.layer.shadowOpacity = 0.5
        loginButton.layer.cornerRadius = 8
        loginButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        
        //loginButton functions
        loginButton.addTarget(self, action: #selector(checkFields), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(highlightButton), for: .touchDown)
        loginButton.addTarget(self, action: #selector(unhighlightButton), for: [.touchUpOutside, .touchUpInside])
        self.view.addSubview(loginButton)
        
        //loginButton constraints
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        let horizLoginButtonConstraint = loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertLoginButtonConstraint = loginButton.topAnchor.constraint(equalTo: password!.bottomAnchor, constant: 40)
        let widthLoginButtonConstraint = loginButton.widthAnchor.constraint(equalToConstant: 150)
        let heightLoginButtonConstraint = loginButton.heightAnchor.constraint(equalToConstant: 50)
        self.view.addConstraints([horizLoginButtonConstraint, vertLoginButtonConstraint, widthLoginButtonConstraint, heightLoginButtonConstraint])
        
        //forgot button
        let forgotButton = UIButton()
        let attributedString = NSAttributedString(
            string: NSLocalizedString("Forgot password?", comment: ""),
            attributes: [
                NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Medium", size: 20)!,
                NSAttributedStringKey.foregroundColor: UIColor.white,
                NSAttributedStringKey.underlineStyle: 1.0
            ])
        forgotButton.titleLabel?.numberOfLines = 1
        forgotButton.titleLabel?.textAlignment = .center
        forgotButton.setAttributedTitle(attributedString, for: .normal)
        
        //forgotButton functions
        forgotButton.addTarget(self, action: #selector(highlightButton), for: .touchDown)
        forgotButton.addTarget(self, action: #selector(unhighlightButton), for: [.touchUpOutside, .touchUpInside])
        self.view.addSubview(forgotButton)
        
        //forgotButton constraints
        forgotButton.translatesAutoresizingMaskIntoConstraints = false
        let horizForgotButtonConstraint = forgotButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertForgotButtonConstraint = forgotButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30)
        let widthForgotButtonConstraint = forgotButton.widthAnchor.constraint(equalToConstant: 220)
        let heightForgotButtonConstraint = forgotButton.heightAnchor.constraint(equalToConstant: 50)
        self.view.addConstraints([horizForgotButtonConstraint, vertForgotButtonConstraint, widthForgotButtonConstraint, heightForgotButtonConstraint])
        
        //memberButton (don't have an account yet button)
        let memberButton = UIButton()
        let attributedStringAcc = NSAttributedString(
            string: NSLocalizedString("Don't have an account yet?", comment: ""),
            attributes: [
                NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Medium", size: 20)!,
                NSAttributedStringKey.foregroundColor: UIColor.white,
                NSAttributedStringKey.underlineStyle: 1.0
            ])
        memberButton.titleLabel?.numberOfLines = 0
        memberButton.titleLabel?.textAlignment = .center
        memberButton.setAttributedTitle(attributedStringAcc, for: .normal)
        
        //memberButton functions
        self.view.addSubview(memberButton)
        
        //memberButton constraints
        memberButton.translatesAutoresizingMaskIntoConstraints = false
        let horizMemberButtonConstraint = memberButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertMemberButtonConstraint = memberButton.topAnchor.constraint(equalTo: forgotButton.bottomAnchor, constant: 10)
        let leftMemberButtonConstraint = memberButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let rightMemberButtonConstraint = view.trailingAnchor.constraint(equalTo: memberButton.trailingAnchor, constant: 20)
        
        self.view.addConstraints([horizMemberButtonConstraint, vertMemberButtonConstraint, leftMemberButtonConstraint, rightMemberButtonConstraint])
        
    }
    
    // General function to validate fields
    @objc func checkFields() {
        if email?.text == "" || password?.text == "" {
            throwMissingFieldsError()
        } else if validEmail(email: (email?.text)!) {
            // TODO: Use credentials to validate with firebase
            checkLogin()
            //print("present CreateAccountChildPromptCodeVC")
            // TODO: check how this changes when embedded in a nav controller
        }
    }
    
    // Highlight the button upon touchDown
    @objc func highlightButton(sender: UIButton!) {
        sender.backgroundColor = UIColor(named: "TSYellowDark")
    }
    
    // Unhighlight the button upon touchDown
    @objc func unhighlightButton(sender: UIButton!) {
        sender.backgroundColor = UIColor(named: "TSYellow")
    }
    
    // Email validation function
    // TODO:
    // - Add validation to check to see if that email has already been registered or not
    // - Move this to VM
    func validEmail(email: String) -> Bool {
        if !email.contains("@") || !email.contains(".") {
            let alert = UIAlertController(title: "Invalid Email", message: "An email must contain '@' and end with a valid domain.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    // Error message presented if there are missing fields
    func throwMissingFieldsError() {
        let alert = UIAlertController(title: "Missing Fields", message: "Email and password are required.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        email?.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSOrange")!])
        password?.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSOrange")!])
    }

    func checkLogin() {
        print("checking login...")
        // TODO: implement check login
    }
}
