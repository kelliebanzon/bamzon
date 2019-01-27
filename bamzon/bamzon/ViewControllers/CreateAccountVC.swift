//
//  CreateAccountVC.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class CreateAccountVC: UIViewController, DisplayableProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor(named: "BZNDarkGray")
        
        // Top Label
        let topLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 120))
        topLabel.center = CGPoint(x: 190, y: 145)
        topLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 27)
        topLabel.textAlignment = .center
        topLabel.numberOfLines = 0
        topLabel.text = "First, tell us a little \rbit about yourself"
        self.view.addSubview(topLabel)
        
        // First Name
        let fNameLabel = UILabel(frame: CGRect(x: 20, y: 200, width: 340, height: 60))
        fNameLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        fNameLabel.text = "What's your first name?"
        self.view.addSubview(fNameLabel)
        
        let firstName = UITextField(frame: CGRect(x: 20, y: 248, width: 340, height: 35))
        firstName.layer.cornerRadius = 8
        firstName.layer.borderWidth = 1.0
        firstName.placeholder = "John"
        self.view.addSubview(firstName)
        
        // Last Name
        let lNameLabel = UILabel(frame: CGRect(x: 20, y: 275, width: 340, height: 60))
        lNameLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        lNameLabel.text = "What's your last name?"
        self.view.addSubview(lNameLabel)
        
        let lastName = UITextField(frame: CGRect(x: 20, y: 323, width: 340, height: 35))
        lastName.layer.cornerRadius = 8
        lastName.layer.borderWidth = 1.0
        lastName.placeholder = "Appleseed"
        self.view.addSubview(lastName)
        
        // Email
        let emailLabel = UILabel(frame: CGRect(x: 20, y: 350, width: 340, height: 60))
        emailLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        emailLabel.text = "What's your email?"
        self.view.addSubview(emailLabel)
        
        let email = UITextField(frame: CGRect(x: 20, y: 398, width: 340, height: 35))
        email.layer.cornerRadius = 8
        email.layer.borderWidth = 1.0
        email.placeholder = "John"
        self.view.addSubview(email)
    }
    
    func display() {
        // TODO: implement display
    }
}


