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
    
    var topLabel = UILabel()
    var loginButton = UIButton()
    var forgotButton = UIButton()
    var memberButton = UIButton()
    
    var email: UITextField?
    var password: UITextField?
    var loginVM = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        display()
        setupAutoLayout()
    }
    
    func display() {
        // TODO: implement display
        view.backgroundColor = UIColor(named: "TSTeal")
        
        let emailPadding = CGRect(x: 0, y: 0, width: 5, height: 20)
        let passwordPadding =  CGRect(x: 0, y: 0, width: 5, height: 20)
   
        //Top label
        topLabel = createDefaultLabel(text: "Sign in with your TeamSync credentials", fontSize: 30, numLines: 0, fontColor: .white, fontAlignment: .center)
        self.view.addSubview(topLabel)

        //Email Text Field
        email = createDefaultTextField(withText: "Email", withFrame: nil, withCenter: nil, withPadding: emailPadding)
        email?.delegate = self
        self.view.addSubview(email!)
        
        //Password Text Field
        password = createDefaultTextField(withText: "Password", withFrame: nil, withCenter: nil, withPadding: passwordPadding)
        password?.isSecureTextEntry = true
        self.view.addSubview(password!)
        
        //Buttons
        
        //loginButton
        loginButton = createDefaultButton(withText: "Log in", withFrame: nil, withAction: #selector(checkLogin), withCenter: nil)
        self.view.addSubview(loginButton)
        
        //forgot button
        forgotButton = UIButton()
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
        self.view.addSubview(forgotButton)
        
        //forgotButton functions
        
        //memberButton (don't have an account yet button)
        memberButton = UIButton()
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
        self.view.addSubview(memberButton)
        
        //memberButton functions
    }
    
    // General function to validate fields
    @objc func checkFields() -> Bool{
        if email?.text == "" || password?.text == "" {
            throwMissingFieldsError()
            return false
        }
        
        if validEmail(email: (email?.text)!) {
            return true
        } else {
            return false
        }
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

    @objc func checkLogin() {
        print("checking login")
        if let errorMessage = loginVM.checkLogin(parent: self, email: email?.text, password: password?.text) {            self.alert(withTitle: "Error", withMessage: errorMessage)
        } else {
            let selectTeamVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectTeamVC")
            present(selectTeamVC, animated: true, completion: nil)
//            // swiftlint:disable force_cast
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            // swiftlint:enable force_cast
//            appDelegate.showTabController()
        }
    }
    
    func setupAutoLayout() {
        let margins = view.safeAreaLayoutGuide

        topLabel.translatesAutoresizingMaskIntoConstraints = false
        let horizLabelConstraint = topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertLabelConstraint = topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80)
        let leftLabelConstraint = topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let rightLabelConstraint = view.trailingAnchor.constraint(equalTo: topLabel.trailingAnchor, constant: 20)
        self.view.addConstraints([horizLabelConstraint, vertLabelConstraint, leftLabelConstraint, rightLabelConstraint])
        
        email?.translatesAutoresizingMaskIntoConstraints = false
        let horizEmailConstraint = email?.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertEmailConstraint = email?.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 50)
        let leftEmailConstraint = email?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let rightEmailConstraint = view.trailingAnchor.constraint(equalTo: (email?.trailingAnchor)!, constant: 20)
        self.view.addConstraints([horizEmailConstraint!, vertEmailConstraint!, leftEmailConstraint!, rightEmailConstraint])
        
        password?.translatesAutoresizingMaskIntoConstraints = false
        let horizPassConstraint = password?.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertPassConstraint = password?.topAnchor.constraint(equalTo: email!.bottomAnchor, constant: 60)
        let leftPassConstraint = password?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let rightPassConstraint = view.trailingAnchor.constraint(equalTo: (password?.trailingAnchor)!, constant: 20)
        self.view.addConstraints([horizPassConstraint!, vertPassConstraint!, leftPassConstraint!, rightPassConstraint])
    
        setupButtonConstraints()
    }
    
    func setupButtonConstraints() {
        //loginButton constraints
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        let horizLoginButtonConstraint = loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertLoginButtonConstraint = loginButton.topAnchor.constraint(equalTo: password!.bottomAnchor, constant: 40)
        let widthLoginButtonConstraint = loginButton.widthAnchor.constraint(equalToConstant: 150)
        let heightLoginButtonConstraint = loginButton.heightAnchor.constraint(equalToConstant: 50)
        self.view.addConstraints([horizLoginButtonConstraint, vertLoginButtonConstraint, widthLoginButtonConstraint, heightLoginButtonConstraint])
        
        //forgotButton constraints
        forgotButton.translatesAutoresizingMaskIntoConstraints = false
        let horizForgotButtonConstraint = forgotButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertForgotButtonConstraint = forgotButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30)
        let widthForgotButtonConstraint = forgotButton.widthAnchor.constraint(equalToConstant: 220)
        let heightForgotButtonConstraint = forgotButton.heightAnchor.constraint(equalToConstant: 50)
        self.view.addConstraints([horizForgotButtonConstraint, vertForgotButtonConstraint, widthForgotButtonConstraint, heightForgotButtonConstraint])
        
        //memberButton constraints
        memberButton.translatesAutoresizingMaskIntoConstraints = false
        let horizMemberButtonConstraint = memberButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertMemberButtonConstraint = memberButton.topAnchor.constraint(equalTo: forgotButton.bottomAnchor, constant: 10)
        let leftMemberButtonConstraint = memberButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let rightMemberButtonConstraint = view.trailingAnchor.constraint(equalTo: memberButton.trailingAnchor, constant: 20)
        
        self.view.addConstraints([horizMemberButtonConstraint, vertMemberButtonConstraint, leftMemberButtonConstraint, rightMemberButtonConstraint])
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
