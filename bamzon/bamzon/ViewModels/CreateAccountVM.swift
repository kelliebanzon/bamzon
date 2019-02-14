//
//  CreateAccountVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

// managing users useful link:
// https://firebase.google.com/docs/auth/ios/manage-users

import Foundation
import Firebase

class CreateAccountVM {
    var parentVC: UIViewController
    var parentVC2: UIViewController?
    
    init(parentVC: UIViewController) {
        self.parentVC = parentVC
    }
    
    func sendVerification() {
        //TODO: Customize verification email
        // You can customize the email template that is used in Authentication section of the Firebase console, on the Email Templates page. See Email Templates in Firebase Help Center:
        //https://support.google.com/firebase/answer/7000714
        if checkUserEmailVerified() {
            let alertController = UIAlertController(title: "Already Verified", message: "User email already verified", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
        } else {
            Auth.auth().currentUser?.sendEmailVerification { (error) in
                if error != nil {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.parentVC.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func checkUserEmailVerified() -> Bool {
        if let curUser = Auth.auth().currentUser {
            return curUser.isEmailVerified
        } else {
            return false
        }
    }
    
    func createAccount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if error == nil {
               // self.parentVC.performSegue(withIdentifier: "signupToHome", sender: self.parentVC)
                guard let user = authResult?.user else { return }
                self.sendVerification()
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                if self.parentVC2 != nil {
                    //TODO: This part is broken except for the alert
                    // It wont segue or set vc2
                    self.parentVC2?.mockSegue(toVC: self.parentVC)
                    print("segued")
                    self.parentVC2!.present(alertController, animated: true, completion: nil)
                    self.parentVC2 = nil
                } else {
                    self.parentVC.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
