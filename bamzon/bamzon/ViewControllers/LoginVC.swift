//
//  LoginVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class LoginVC: UIViewController, DisplayableProtocol {
    
    var email : UITextField?
    var password: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        display();
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
        self.view.addSubview(topLabel);
        
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
        self.view.addSubview(email!)
        
        //Email Text Field constraints
        email?.translatesAutoresizingMaskIntoConstraints = false
        let horizEmailConstraint = email?.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertEmailConstraint = email?.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 50)
        let leftEmailConstraint = email?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let rightEmailConstraint = view.trailingAnchor.constraint(equalTo: (email?.trailingAnchor)!, constant: 20)
        self.view.addConstraints([horizEmailConstraint!, vertEmailConstraint!, leftEmailConstraint!, rightEmailConstraint])
        
        //Email Bar
        /*let emailBar = CAShapeLayer()
        emailBar.path = UIBezierPath(roundedRect: CGRect(), cornerRadius: 8).cgPath
        emailBar.fillColor = UIColor.white.cgColor
        self.view.layer.addSublayer(emailBar)*/
        
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
        self.view.addSubview(loginButton)
        
        //loginButton constraints
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        let horizLoginButtonConstraint = loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertLoginButtonConstraint = loginButton.topAnchor.constraint(equalTo: password!.bottomAnchor, constant: 40)
        let widthLoginButtonConstraint = loginButton.widthAnchor.constraint(equalToConstant: 150)
        let heightLoginButtonConstraint = loginButton.heightAnchor.constraint(equalToConstant: 50)
        self.view.addConstraints([horizLoginButtonConstraint, vertLoginButtonConstraint, widthLoginButtonConstraint, heightLoginButtonConstraint])
        
        let forgotButton = UIButton()
        forgotButton.setTitle("Forgot Password?", for: .normal)
        forgotButton.backgroundColor = UIColor(named: "TSYellow")
        forgotButton.layer.shadowColor = UIColor.black.cgColor
        forgotButton.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        forgotButton.layer.masksToBounds = false
        forgotButton.layer.shadowRadius = 1.0
        forgotButton.layer.shadowOpacity = 0.5
        forgotButton.layer.cornerRadius = 8
        forgotButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        self.view.addSubview(forgotButton)
        
        //loginButton constraints
        forgotButton.translatesAutoresizingMaskIntoConstraints = false
        let horizForgotButtonConstraint = forgotButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertForgotButtonConstraint = forgotButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30)
        let widthForgotButtonConstraint = forgotButton.widthAnchor.constraint(equalToConstant: 220)
        let heightForgotButtonConstraint = forgotButton.heightAnchor.constraint(equalToConstant: 50)
        self.view.addConstraints([horizForgotButtonConstraint, vertForgotButtonConstraint, widthForgotButtonConstraint, heightForgotButtonConstraint])
        
        let memberButton = UIButton()
        memberButton.setTitle("Already a member?", for: .normal)
        memberButton.backgroundColor = UIColor(named: "TSYellow")
        memberButton.layer.shadowColor = UIColor.black.cgColor
        memberButton.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        memberButton.layer.masksToBounds = false
        memberButton.layer.shadowRadius = 1.0
        memberButton.layer.shadowOpacity = 0.5
        memberButton.layer.cornerRadius = 8
        memberButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        self.view.addSubview(memberButton)
        
        //loginButton constraints
        memberButton.translatesAutoresizingMaskIntoConstraints = false
        let horizMemberButtonConstraint = memberButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertMemberButtonConstraint = memberButton.topAnchor.constraint(equalTo: forgotButton.bottomAnchor, constant: 30)
        let widthMemberButtonConstraint = memberButton.widthAnchor.constraint(equalToConstant: 220)
        let heightMemberButtonConstraint = memberButton.heightAnchor.constraint(equalToConstant: 50)
        self.view.addConstraints([horizMemberButtonConstraint, vertMemberButtonConstraint, widthMemberButtonConstraint, heightMemberButtonConstraint])
        
    }
    
    func checkLogin() {
        // TODO: implement check login
    }
}
