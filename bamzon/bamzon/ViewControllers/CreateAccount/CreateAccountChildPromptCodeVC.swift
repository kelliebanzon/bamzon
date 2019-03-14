//
//  CreateAccountChildPromptCodeVC.swift
//  bamzon
//
//  Created by Kellie Banzon on 02/07/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountChildPromptCodeVC: UIViewController, DisplayableProtocol, UITextFieldDelegate {

    var email: String?
    var name: String?
    var code: UITextField?
    var topLabel = UILabel()
    var backPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
        // Do any additional setup after loading the view.
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        
        // Create X***@X***.XXX string
        var shortEmail = String(email![email!.startIndex]) + "***@" + String(email![email!.index(after: email!.lastIndex(of: "@")!)])
        shortEmail += "***" + String(email!.suffix(from: email!.lastIndex(of: ".")!))
        
        // Top Label
        topLabel = createDefaultHeader1Label(text: "Please enter the \rsecurity code emailed \rto " + shortEmail, numLines: 0, fontAlignment: .center)
        
        self.view.addSubview(topLabel)
        
        // Security Code
        code = createDefaultTextField(withText: "Security Code", withFrame: nil, withCenter: CGPoint(x: view.frame.midX, y: view.frame.midY - 35), withPadding: nil)
        self.view.addSubview(code!)
        
        // Verify Button
        let verify = createDefaultButton(withText: "Verify", withFrame: CGRect(x: 0, y: 0, width: 150, height: 50), withAction: #selector(verifyCode), withCenter: CGPoint(x: view.center.x, y: view.frame.midY + 35))
        //verify.addTarget(self, action: #selector(highlightverify), for: .touchDown)
        //verify.addTarget(self, action: #selector(unhighlightverify), for: [.touchUpOutside, .touchUpInside])
        self.view.addSubview(verify)
        
        setupAutoLayout()
    }
    
    func setupAutoLayout() {
        let margins = view.layoutMarginsGuide
        
        // Top Label constraints
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        let topLabelTopConstraint = topLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20)
        let topLabelLeftConstraint = topLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20)
        let topLabelRightConstraint = margins.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 20)
        self.view.addConstraints([topLabelTopConstraint, topLabelLeftConstraint, topLabelRightConstraint])
    }
    
    @objc func unwindToPrevious() {
        if let prevVC = storyboard!.instantiateViewController(withIdentifier: "CreateChild") as? CreateAccountChildSuccessVC {
            present(prevVC, animated: true, completion: nil)
        }
    }
    
    // Function call to VM to verify code
    @objc func verifyCode() {
        let dispatch = DispatchGroup()
        waitForVerification()
        dispatch.notify(queue: DispatchQueue.main) {
            if let nextVC = self.storyboard!.instantiateViewController(withIdentifier: "CreateAccountChildSuccessVC") as? CreateAccountChildSuccessVC {
                nextVC.name = self.name!
                self.present(nextVC, animated: true, completion: nil)
            } else {
                self.alert(withTitle: "Error", withMessage: "Something went wrong. Please refresh your app and try again.")
            }
        }
    }
    
    func waitForVerification() {
        if let user = Auth.auth().currentUser {
            while !user.isEmailVerified {
                user.reload()
                if user.isEmailVerified {
                    return
                }
                sleep(200)
            }
        } else {
            self.alert(withTitle: "Error", withMessage: "User has not been initialized.")
        }
    }
    
    // Hide keyboard when pressed out of text box
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
