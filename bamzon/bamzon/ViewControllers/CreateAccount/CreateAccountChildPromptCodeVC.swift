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
        topLabel = createDefaultHeader1Label(text: "Please enter the \rsecurity code emailed \rto " + shortEmail, numLines: 0)
        topLabel.textAlignment = .center
        
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
        if waitForVerification() {
            if let nextVC = storyboard!.instantiateViewController(withIdentifier: "CreateAccountChildSuccessVC") as? CreateAccountChildSuccessVC {
                nextVC.name = name!
                present(nextVC, animated: true, completion: nil)
            }
        } else {
            alert(withTitle: "Uh oh!", withMessage: "That code doesn't look right 😰\rPlease try again.")
        }
    }
    
    func waitForVerification() -> Bool {
        while backPressed {
            Auth.auth().currentUser!.reload()
            if Auth.auth().currentUser!.isEmailVerified {
                mockSegue(toIdentifier: "CreateAccountChildSuccessVC")
                return true
            }
            sleep(500)
        }
        return false
    }
    
    // Hide keyboard when pressed out of text box
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//    @ kyle: when you're ready to transition to the account success creation page,
//    add this line of code to your function:

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
