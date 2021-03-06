//
//  CreateAccountVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Written by Kyle Vu on 1/27/19
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class CreateAccountMasterVC: UIViewController, DisplayableProtocol {
    
    var firstName: UITextField?
    var lastName: UITextField?
    var email: UITextField?
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor(named: "TSNavy")
        display()
        
        // add container
//        let containerView = UIView()
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(containerView)
//        NSLayoutConstraint.activate([
//            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
//            ])
//
//        // add child view controller view to container
//
//        let childVC = storyboard!.instantiateViewController(withIdentifier: "CreateAccountChild1VC")
//        addChildViewController(childVC)
//        childVC.view.translatesAutoresizingMaskIntoConstraints = false
//        containerView.addSubview(childVC.view)
//
//        NSLayoutConstraint.activate([
//            childVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
//            childVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//            childVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
//            childVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
//            ])
//
//        childVC.didMove(toParentViewController: self)
        
        //Some property on ChildVC that needs to be set
        //childVC.dataSource = self
    }
    
    func display() {
        
        // Padding variables
        let firstPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        let lastPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        let emailPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        
        // Top Label
        let topLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 120))
        topLabel.center = CGPoint(x: view.frame.midX, y: 150)
        topLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 0
        topLabel.textColor = .white
        topLabel.text = "First, tell us a little \rbit about yourself!"
        self.view.addSubview(topLabel)
        
        // First Name
        firstName = UITextField(frame: CGRect(x: 20, y: 240, width: 340, height: 35))
        firstName?.leftView = firstPaddingView
        firstName?.leftViewMode = .always
        firstName?.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSWhite75")!])
        firstName?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        firstName?.textColor = .white
        self.view.addSubview(firstName!)
        
        let nameBar = CAShapeLayer()
        nameBar.path = UIBezierPath(roundedRect: CGRect(x: 20, y: 275, width: view.frame.width - 40, height: 2), cornerRadius: 8).cgPath
        nameBar.fillColor = UIColor.white.cgColor
        self.view.layer.addSublayer(nameBar)
        
        // Last Name
        lastName = UITextField(frame: CGRect(x: 20, y: 300, width: 340, height: 35))
        lastName?.leftView = lastPaddingView
        lastName?.leftViewMode = .always
        lastName?.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSWhite75")!])
        lastName?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        lastName?.textColor = .white
        self.view.addSubview(lastName!)
        
        let lastBar = CAShapeLayer()
        lastBar.path = UIBezierPath(roundedRect: CGRect(x: 22, y: 335, width: 335, height: 2), cornerRadius: 8).cgPath
        lastBar.fillColor = UIColor.white.cgColor
        self.view.layer.addSublayer(lastBar)
        
        // Email
        email = UITextField(frame: CGRect(x: 20, y: 360, width: 355, height: 35))
        email?.leftView = emailPaddingView
        email?.leftViewMode = .always
        email?.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSWhite75")!])
        email?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        email?.textColor = .white
        email?.autocapitalizationType = UITextAutocapitalizationType(rawValue: 0)!
        email?.autocorrectionType = UITextAutocorrectionType(rawValue: 0)!
        self.view.addSubview(email!)
        
        let emailBar = CAShapeLayer()
        emailBar.path = UIBezierPath(roundedRect: CGRect(x: 22, y: 395, width: 335, height: 2), cornerRadius: 8).cgPath
        emailBar.fillColor = UIColor.white.cgColor
        self.view.layer.addSublayer(emailBar)
        
        // Next Button
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        button.center = CGPoint(x: view.center.x, y: 450)
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = UIColor(named: "TSYellow")
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 1.0
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        button.addTarget(self, action: #selector(checkFields), for: .touchUpInside)
        button.addTarget(self, action: #selector(highlightButton), for: .touchDown)
        button.addTarget(self, action: #selector(unhighlightButton), for: [.touchUpOutside, .touchUpInside])
        //button.addTarget(self, action: #selector(unhighlightButton), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    // Highlight the button upon touchDown
    @objc func highlightButton(sender: UIButton!) {
        sender.backgroundColor = UIColor(named: "TSYellowDark")
    }
    
    // Unhighlight the button upon touchDown
    @objc func unhighlightButton(sender: UIButton!) {
        sender.backgroundColor = UIColor(named: "TSYellow")
    }
    
    // General function to validate fields
    @objc func checkFields(sender: UIButton!) {
        if firstName?.text == "" || lastName?.text == "" || email?.text == "" {
            missingFieldsError()
        } else if validEmail(email: (email?.text)!) {
            // Initial account creation in the backend should go here
            initialAccountCreation(fName: (firstName?.text)!, lName: (lastName?.text)!, email: (email?.text)!)
        } else {
            print("performSegue ShowCreateAccountPromptEmail")
            // TODO: performSegue(withIdentifier: "ShowCreateAccountPromptEmail", sender: self)
        }
    }
    
    func initialAccountCreation(fName: String, lName: String, email: String) {
        print("Valid Input:")
        print("\tFirst Name: " + fName)
        print("\t Last Name: " + lName)
        print("\t     Email: " + email)
    }
    
    // Email validation function
    // TODO:
    // - Add validation to check to see if that email has already been registered or not
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
    func missingFieldsError() {
        let alert = UIAlertController(title: "Missing Fields", message: "First name, last name, and a valid email are requried.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        firstName?.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSOrange")!])
        lastName?.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSOrange")!])
        email?.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSOrange")!])
    }

}
