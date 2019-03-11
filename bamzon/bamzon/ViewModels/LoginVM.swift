//
//  LoginVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//
// Managing a user's info:
// https://firebase.google.com/docs/auth/ios/manage-users

import Foundation
import FirebaseAuth
import Firebase

class LoginVM {
    
    func checkLogin(parent: UIViewController, email: String?, password: String?) -> String? {
        var waitingForLogin = true
        var errorMessage: String?
        
        guard let email = email, let password = password else {
            return "Please enter a valid input."
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                errorMessage = error?.localizedDescription ?? "Error signing in."
            } else {
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    DBUtility.readFromDB(table: FirTable.firebaseID, keys: user!.user.uid, completion: {(key: String, payload: [String: AnyObject]) -> Void in
                        appDelegate.curUser = User(key: key, payload: payload)
                    })
                }
            }
            waitingForLogin = false
        }
        
        while !waitingForLogin {}

        //citing sources: https://stackoverflow.com/questions/38061203/how-to-verify-a-users-email-address-on-ios-with-firebase/38406024
        if let user = Auth.auth().currentUser {
            user.reload(completion: nil)
            if !user.isEmailVerified {
                return "Sorry. The email address \(String(describing: user.email)) has not yet been verified."
                //TODO actionable resend verification email
                /*
                let alertVC = UIAlertController(title: "Error", message: "Sorry. Your email address has not yet been verified. Do you want us to send another verification email to \(String(describing: user.email)).", preferredStyle: .alert)
                let alertActionOkay = UIAlertAction(title: "Okay", style: .default) {
                    (_) in
                    user.sendEmailVerification(completion: nil)
                }
                let alertActionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)

                alertVC.addAction(alertActionOkay)
                alertVC.addAction(alertActionCancel)
                parent.present(alertVC, animated: true, completion: nil)*/
            }
        }
        return errorMessage
    }
}
