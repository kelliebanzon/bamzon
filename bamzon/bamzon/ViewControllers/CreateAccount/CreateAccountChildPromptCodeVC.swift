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
    var backPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
        // Do any additional setup after loading the view.
    }
    
    func display() {
        view.backgroundColor = UIColor(named: "TSTeal")
        
        // TODO: temporary identifier code. delete this once you write the real display func
        // Temp Label
        let tempLabel = pageLabel(withText: "Please enter the \rsecurity code emailed \rto " + email!, withFrame: CGRect(x: 0, y: 30, width: 400, height: 120), withCenter: nil)
        self.view.addSubview(tempLabel)
        
        // Security Code
        code = createDefaultTextField(withText: "Security Code", withFrame: nil, withCenter: CGPoint(x: view.frame.midX, y: view.frame.midY - 35), withPadding: nil)
        self.view.addSubview(code!)
        
        // Verify Button
        let verify = createDefaultButton(withText: "Verify", withFrame: CGRect(x: 0, y: 0, width: 150, height: 50), withAction: #selector(verifyCode), withCenter: CGPoint(x: view.center.x, y: view.frame.midY + 35))
        //verify.addTarget(self, action: #selector(highlightverify), for: .touchDown)
        //verify.addTarget(self, action: #selector(unhighlightverify), for: [.touchUpOutside, .touchUpInside])
        self.view.addSubview(verify)
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
