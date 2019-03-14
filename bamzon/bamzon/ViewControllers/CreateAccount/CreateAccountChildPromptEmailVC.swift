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
    
    var topLabel: UILabel?
    var firstName: UITextField?
    var lastName: UITextField?
    var email: UITextField?
    var password: UITextField?
    var continueButton: UIButton?
    var existingAccount: UIButton?
    var user: User?
    var nextVC: CreateAccountChildPromptCodeVC?
    
    var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 1000
        view.backgroundColor = UIColor(named: "TSTeal")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        display()
        self.view.addSubview(scrollView)
        setupScrollView()
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        password?.isSecureTextEntry = true
        
        // Top Label
        topLabel = createDefaultHeader1Label(text: "First, tell us a little \rbit about yourself!", numLines: 2)
        topLabel!.textAlignment = .center
        self.view.addSubview(topLabel!)
        
        // First Name
        firstName = createDefaultTextField(withText: "First Name", withFrame: nil, withCenter: nil, withPadding: nil)
        firstName?.autocorrectionType = UITextAutocorrectionType(rawValue: 0)!
        firstName?.spellCheckingType = UITextSpellCheckingType(rawValue: 0)!
        scrollView.addSubview(firstName!)
        
        // Last Name
        lastName = createDefaultTextField(withText: "Last Name", withFrame: nil, withCenter: nil, withPadding: nil)
        lastName?.autocorrectionType = UITextAutocorrectionType(rawValue: 0)!
        lastName?.spellCheckingType = UITextSpellCheckingType(rawValue: 0)!
        scrollView.addSubview(lastName!)
        
        // Email
        email = createDefaultTextField(withText: "Email", withFrame: nil, withCenter: nil, withPadding: nil)
        email?.autocapitalizationType = UITextAutocapitalizationType(rawValue: 0)!
        email?.autocorrectionType = UITextAutocorrectionType(rawValue: 0)!
        email?.spellCheckingType = UITextSpellCheckingType(rawValue: 0)!
        email?.delegate = self
        scrollView.addSubview(email!)
        
        // Password
        password = createDefaultTextField(withText: "Password", withFrame: nil, withCenter: nil, withPadding: nil)
        password?.autocapitalizationType = UITextAutocapitalizationType(rawValue: 0)!
        password?.autocorrectionType = UITextAutocorrectionType(rawValue: 0)!
        password?.spellCheckingType = UITextSpellCheckingType(rawValue: 0)!
        scrollView.addSubview(password!)
        
        // Continue Button
        continueButton = createDefaultButton(withText: "Continue", withFrame: nil, withAction: #selector(tryCreateAccount), withCenter: CGPoint(x: view.center.x, y: 450))
        scrollView.addSubview(continueButton!)
        
        // Existing Account Button
        existingAccount = createDefaultTextButton(withText: "Already have an account?", withAction: #selector(loginPage), withFrame: nil, withCenter: CGPoint(x: view.center.x, y: 515), withNumLines: nil)
        scrollView.addSubview(existingAccount!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //validFields()
        return true
    }
    
    func setupScrollView() {
        // Use "nav.navigationBar.bottomAnchor" after navigation bar is placed
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 190).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        // Top label constraints
        topLabel!.translatesAutoresizingMaskIntoConstraints = false
        let horizLabelConstraint = topLabel!.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let vertLabelConstraint = topLabel!.topAnchor.constraint(equalTo: view.topAnchor, constant: 80)
        let leftLabelConstraint = topLabel!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        let rightLabelConstraint = view.trailingAnchor.constraint(equalTo: topLabel!.trailingAnchor, constant: 20)
        self.view.addConstraints([horizLabelConstraint, vertLabelConstraint, leftLabelConstraint, rightLabelConstraint])
        
        // First name constraints
        firstName?.translatesAutoresizingMaskIntoConstraints = false
        let horizFNameConstraint = firstName?.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        let vertFNameConstraint = firstName?.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10)
        let leftFNameConstraint = firstName?.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20)
        let rightFNameConstraint = scrollView.trailingAnchor.constraint(equalTo: (firstName?.trailingAnchor)!, constant: 20)
        scrollView.addConstraints([horizFNameConstraint!, vertFNameConstraint!, leftFNameConstraint!, rightFNameConstraint])
        
        // Last name constraints
        lastName?.translatesAutoresizingMaskIntoConstraints = false
        let horizLNameConstraint = lastName?.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        let vertLNameConstraint = lastName?.topAnchor.constraint(equalTo: (firstName?.bottomAnchor)!, constant: 30)
        let leftLNameConstraint = lastName?.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20)
        let rightLNameConstraint = scrollView.trailingAnchor.constraint(equalTo: (lastName?.trailingAnchor)!, constant: 20)
        scrollView.addConstraints([horizLNameConstraint!, vertLNameConstraint!, leftLNameConstraint!, rightLNameConstraint])
        
        // Email constraints
        email?.translatesAutoresizingMaskIntoConstraints = false
        let horizEmailConstraint = email?.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        let vertEmailConstraint = email?.topAnchor.constraint(equalTo: (lastName?.bottomAnchor)!, constant: 30)
        let leftEmailConstraint = email?.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20)
        let rightEmailConstraint = scrollView.trailingAnchor.constraint(equalTo: (email?.trailingAnchor)!, constant: 20)
        scrollView.addConstraints([horizEmailConstraint!, vertEmailConstraint!, leftEmailConstraint!, rightEmailConstraint])
        
        // Password constraints
        password?.translatesAutoresizingMaskIntoConstraints = false
        let horizPasswordConstraint = password?.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        let vertPasswordConstraint = password?.topAnchor.constraint(equalTo: (email?.bottomAnchor)!, constant: 30)
        let leftPasswordConstraint = password?.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20)
        let rightPasswordConstraint = scrollView.trailingAnchor.constraint(equalTo: (password?.trailingAnchor)!, constant: 20)
        scrollView.addConstraints([horizPasswordConstraint!, vertPasswordConstraint!, leftPasswordConstraint!, rightPasswordConstraint])
        
        // Continue button constraints
        continueButton!.translatesAutoresizingMaskIntoConstraints = false
        let horizContinueConstraint = continueButton!.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        let vertContinueConstraint = continueButton!.topAnchor.constraint(equalTo: (password?.bottomAnchor)!, constant: 30)
        let bottomContinueConstraint = continueButton!.bottomAnchor.constraint(equalTo: continueButton!.topAnchor, constant: 50)
        let leftContinueConstraint = continueButton!.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -70)
        let rightContinueConstraint = continueButton!.trailingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 70)
        scrollView.addConstraints([horizContinueConstraint, vertContinueConstraint, bottomContinueConstraint, leftContinueConstraint, rightContinueConstraint])
        
        // Existing account constraints
        existingAccount!.translatesAutoresizingMaskIntoConstraints = false
        let horizExistingConstraint = existingAccount!.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        let vertExistingConstraint = existingAccount!.topAnchor.constraint(equalTo: continueButton!.bottomAnchor, constant: 20)
        let leftExistingConstraint = existingAccount!.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20)
        let rightExistingConstraint = scrollView.trailingAnchor.constraint(equalTo: existingAccount!.trailingAnchor, constant: 20)
        scrollView.addConstraints([horizExistingConstraint, vertExistingConstraint, leftExistingConstraint, rightExistingConstraint])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Send user to login page if they have an existing account
    @objc func loginPage() {
        self.setRootView(toVC: "LoginVC")
    }
    
    @objc func tryCreateAccount() {
        if checkValidFields() {
            if validEmail(email: (email?.text)!) {
                initialAccountCreation(fName: (firstName?.text)!, lName: (lastName?.text)!, email: (email?.text)!)
            } else {
                invalidEmailAlert()
            }
        } else {
            missingFieldsAlert()
        }
    }
    
    @objc func invalidEmailAlert() {
        let alert = UIAlertController(title: "Invalid Email", message: "An email must contain '@' and end with a valid domain.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
        
    // General function to validate fields
    @objc func checkValidFields() -> Bool {
        return !(firstName?.text?.isEmpty)! || !(lastName?.text?.isEmpty)!  || !(email?.text?.isEmpty)!
    }
    
    func initialAccountCreation(fName: String, lName: String, email: String) {
        //TODO: place for a password. change variable in create account
        // to view or modify current users go here:
        // https://console.firebase.google.com/u/1/project/bamzon-876ab/authentication/users
        if let parent = self.parent as? CreateAccountParentVC {
            let dispatch = DispatchGroup()
            showSpinner(onView: view)
            parent.createAccountVM.creationErrorMessage = nil
            parent.createAccountVM.createAccount(fname: fName, lname: lName, email: email, password: "password", dispatch: dispatch)
            
            dispatch.notify(queue: DispatchQueue.main) {
                self.removeSpinner()
                if let errorMessage = parent.createAccountVM.creationErrorMessage {
                    self.alert(withTitle: "Error", withMessage: errorMessage)
                } else {
                    // swiftlint:disable force_cast
                    let createAccountNextVC = self.storyboard!.instantiateViewController(withIdentifier: "CreateAccountChildSuccessVC") as! CreateAccountChildSuccessVC
                    // swiftlint:enable force_cast
                    self.present(createAccountNextVC, animated: true, completion: nil)
                }
            }
            
        } else {
            self.alert(withTitle: "Error", withMessage: "An unexpected error has occured. Please restart your app and try again.")
            print("parentVC is not CreateAccountParent")
        }
    }
    
    // Email validation function
    // TODO:
    // - Move this to VM
    func validEmail(email: String) -> Bool {
       return email.contains("@") && email.contains(".")
    }
    
    // Error message presented if there are missing fields
    func missingFieldsAlert() {
        let alert = UIAlertController(title: "Missing Fields", message: "First name, last name, and a valid email are requried.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        firstName?.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSOrange")!])
        lastName?.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSOrange")!])
        email?.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSOrange")!])
        password?.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "TSOrange")!])
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "captured" {
            let isCaptured = UIScreen.main.isCaptured
            alert(withTitle: "⚠️ WARNING ⚠️", withMessage: "Screen recording detected!")
            print(isCaptured)
        }
    }

}
