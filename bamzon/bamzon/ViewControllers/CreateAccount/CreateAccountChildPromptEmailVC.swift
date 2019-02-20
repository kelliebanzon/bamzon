//
//  CreateAccountChildPromptEmailVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/05/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateAccountChildPromptEmailVC: UIViewController, DisplayableProtocol, UITextFieldDelegate {
    
    var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 1000
        view.backgroundColor = UIColor(named: "TSTeal")
        return view
    }()
    
    var firstName: UITextField?
    var lastName: UITextField?
    var email: UITextField?
    var createAccountVM: CreateAccountVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAccountVM = CreateAccountVM.init(parentVC: self)
        // Do any additional setup after loading the view.
        display()
        self.view.addSubview(scrollView)
        setupScrollView()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkFields()
        return true
    }
    
    func setupScrollView() {
        // Use "nav.navigationBar.bottomAnchor" after navigation bar is placed
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant:  70).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        // Top Label
        let topLabel = pageLabel(withText: "First, tell us a little \rbit about yourself!", withFrame: nil, withCenter: nil)
        scrollView.addSubview(topLabel)
        
        /*topLabel.translatesAutoresizingMaskIntoConstraints = false
        let horizLabelConstraint = topLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let vertLabelConstraint = topLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20)
        let leftLabelConstraint = topLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
        //Why is this one switched? view first instead of topLabel?
        let rightLabelConstraint = self.view.trailingAnchor.constraint(equalTo: topLabel.trailingAnchor, constant: 20)
        scrollView.addConstraints([horizLabelConstraint, vertLabelConstraint, leftLabelConstraint, rightLabelConstraint])*/
        
        // First Name
        firstName = createDefaultTextField(withText: "First Name", withFrame: CGRect(x: 20, y: 240, width: 340, height: 35), withCenter: nil, withPadding: nil)
        scrollView.addSubview(firstName!)
        
        /*firstName?.translatesAutoresizingMaskIntoConstraints = false
        let horizFNameConstraint = firstName?.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertFNameConstraint = firstName?.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 90)
        let leftFNameConstraint = firstName?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let rightFNameConstraint = view.trailingAnchor.constraint(equalTo: (firstName?.trailingAnchor)!, constant: 20)
        scrollView.addConstraints([horizFNameConstraint!, vertFNameConstraint!, leftFNameConstraint!, rightFNameConstraint])*/
        
        // Last Name
        lastName = createDefaultTextField(withText: "Last Name", withFrame: CGRect(x: 20, y: 300, width: 340, height: 35), withCenter: nil, withPadding: nil)
        scrollView.addSubview(lastName!)
        
        // Email
        email = createDefaultTextField(withText: "Email", withFrame: CGRect(x: 20, y: 360, width: 355, height: 35), withCenter: nil, withPadding: nil)
        email?.autocapitalizationType = UITextAutocapitalizationType(rawValue: 0)!
        email?.autocorrectionType = UITextAutocorrectionType(rawValue: 0)!
        email?.delegate = self
        scrollView.addSubview(email!)
        
        // Next Button
        let button = createDefaultButton(withText: "Continue", withFrame: CGRect(x: 0, y: 0, width: 150, height: 50), withAction: #selector(checkFields), withCenter: CGPoint(x: view.center.x, y: 450))
        scrollView.addSubview(button)
        
        // Existing Account Button
        let existingAccount = defaultTextButton(withText: "Already have an account?", withAction: #selector(loginPage), withFrame: nil, withCenter: CGPoint(x: view.center.x, y: 515), withNumLines: nil)
        scrollView.addSubview(existingAccount)
    }
    
    // Send user to login page if they have an existing account
    @objc func loginPage() {
        self.mockSegue(toIdentifier: "LoginVC")
    }
    
    // General function to validate fields
    @objc func checkFields() {
        if firstName?.text == "" || lastName?.text == "" || email?.text == "" {
            throwMissingFieldsError()
        } else if validEmail(email: (email?.text)!) {
            // Initial account creation in the backend should go here
            initialAccountCreation(fName: (firstName?.text)!, lName: (lastName?.text)!, email: (email?.text)!)
            if Auth.auth().currentUser != nil {
                // TODO: check how this changes when embedded in a nav controller
                if let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "CreateAccountChildPromptCodeVC") as? CreateAccountChildPromptCodeVC {
                    if firstName != nil && lastName != nil && email != nil {
                        nextVC.name = (firstName?.text)! + " " + (lastName?.text)!
                        nextVC.email = (email?.text)!
                        createAccountVM?.parentVC = nextVC
                        
                        self.mockSegue(toVC: nextVC)
                    }
                }
            } else {
                return
            }
        }
    }
    
    func initialAccountCreation(fName: String, lName: String, email: String) {
        print("Valid Input:")
        print("\tFirst Name: " + fName)
        print("\t Last Name: " + lName)
        print("\t     Email: " + email)

        //TODO: place for a password. change variable in create account
        // to view or modify current users go here:
        // https://console.firebase.google.com/u/1/project/bamzon-876ab/authentication/users
        if createAccountVM != nil {
            createAccountVM!.createAccount(email: email, password: "password")
        } else {
            let alert = UIAlertController(title: "Error", message: "Error, try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)        }
        return
    }
    
    // Email validation function
    // TODO:
    // - Add validation to check to see if that email has already been registered or not
    //     - Firebase already does this.
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
    //TODO: make error color less harsh
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
