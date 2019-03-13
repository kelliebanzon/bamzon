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
    
    var firstName: UITextField?
    var lastName: UITextField?
    var email: UITextField?
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
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //validFields()
        return true
    }
    
    func setupScrollView() {
        // Use "nav.navigationBar.bottomAnchor" after navigation bar is placed
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
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
        let button = createDefaultButton(withText: "Continue", withFrame: CGRect(x: 0, y: 0, width: 150, height: 50), withAction: #selector(tryCreateAccount), withCenter: CGPoint(x: view.center.x, y: 450))
        scrollView.addSubview(button)
        
        // Existing Account Button
        let existingAccount = createDefaultTextButton(withText: "Already have an account?", withAction: #selector(loginPage), withFrame: nil, withCenter: CGPoint(x: view.center.x, y: 515), withNumLines: nil)
        // @Kellie - sizing is being a bitch. It's smaller than "Don't have an account?"
        scrollView.addSubview(existingAccount)
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
            parent.createAccountVM.createAccount(fname: fName, lname: lName, email: email, password: "password", dispatch: dispatch)
            
            dispatch.notify(queue: DispatchQueue.main) {
                if let errorMessage = parent.createAccountVM.creationErrorMessage {
                    self.alert(withTitle: "Error", withMessage: errorMessage)
                } else {
                    let createAccountChild = self.storyboard!.instantiateViewController(withIdentifier: "CreateAccountChildPromptCodeVC") as? CreateAccountChildPromptCodeVC
                    createAccountChild!.name = fName + " " + lName
                    createAccountChild!.email = email
                    self.present(createAccountChild!, animated: true, completion: nil)
                }
                //            // swiftlint:disable force_cast
                //            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                //            // swiftlint:enable force_cast
                //            appDelegate.showTabController()
            }
            
        } else {
            self.alert(withTitle: "Error", withMessage: "An unexpected error has occured, please restart your app and try again")
            print("parentVC is not CreateAccountParent")
        }
    }
    
    // Email validation function
    // TODO:
    // - Add validation to check to see if that email has already been registered or not
    //     - Firebase already does this.
    // - Move this to VM
    func validEmail(email: String) -> Bool {
       return email.contains("@") && email.contains(".")
    }
    
    // Error message presented if there are missing fields
    //TODO: make error color less harsh
    func missingFieldsAlert() {
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
