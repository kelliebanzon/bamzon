//
//  CreateAccountChildPromptEmailVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/05/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit

class CreateAccountChildPromptEmailVC: UIViewController, DisplayableProtocol, UITextFieldDelegate {
    
    var firstName : UITextField?
    var lastName : UITextField?
    var email : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        display()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        
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
        email?.delegate = self
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
        self.view.addSubview(button)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkFields()
        return true
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
    @objc func checkFields() {
        if (firstName?.text == "" || lastName?.text == "" || email?.text == "")
        {
            throwMissingFieldsError()
        } else if (validEmail(email: (email?.text)!)){
            // Initial account creation in the backend should go here
            initialAccountCreation(fName: (firstName?.text)!, lName: (lastName?.text)!, email: (email?.text)!)
            //print("present CreateAccountChildPromptCodeVC")
            // TODO: check how this changes when embedded in a nav controller
            let nextVC = storyboard!.instantiateViewController(withIdentifier: "CreateAccountChildPromptCodeVC")
            present(nextVC, animated: true, completion: nil)
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
    // - Move this to VM
    func validEmail(email: String) -> Bool {
        if (!email.contains("@") || !email.contains(".")) {
            let alert = UIAlertController(title: "Invalid Email", message: "An email must contain '@' and end with a valid domain.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    // Error message presented if there are missing fields
    func throwMissingFieldsError() {
        let alert = UIAlertController(title: "Missing Fields", message: "First name, last name, and a valid email are requried.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        firstName?.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSOrange")!])
        lastName?.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSOrange")!])
        email?.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSOrange")!])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
