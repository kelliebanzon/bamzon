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

class LoginVM: ViewModel {
    
    func checkLogin(parent: UIViewController, email: String?, password: String?) -> Bool {
        var validLogin = false
        let group = DispatchGroup()
        
        guard let email = email, let password = password else {
            parent.alert(withTitle: "Invalid Input", withMessage: "Please enter a valid input.")
            return false
        }
        return true
        
//        group.enter()
//        print("entered")
//        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
//            print("inside")
//            if error != nil {
//                parent.alert(withTitle: "Error", withMessage: error?.localizedDescription ?? "Error signing in.")
//                validLogin = false
//            } else {
//                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//                    group.enter()
//                    print("entered")
//                    DBUtility.readFromDB(table: FirTable.firebaseIDs, keys: user!.user.uid, completion: {(key: String, payload: [String: AnyObject]) -> Void in
//                        appDelegate.curUser = User(key: key, payload: payload)
//                        group.leave()
//                        print("left")
//                    })
//                }
//                print("boutta wait")
//                group.wait()
//                print("finished waiting")
//            }
//            group.leave()
//            print("left")
//
//        }
//        group.wait()
//
//        //citing sources: https://stackoverflow.com/questions/38061203/how-to-verify-a-users-email-address-on-ios-with-firebase/38406024
//        if let user = Auth.auth().currentUser {
//            user.reload(completion: nil)
//            if !user.isEmailVerified {
//                let alertVC = UIAlertController(title: "Error", message: "Sorry. Your email address has not yet been verified. Do you want us to send another verification email to \(String(describing: user.email)).", preferredStyle: .alert)
//                let alertActionOkay = UIAlertAction(title: "Okay", style: .default) {
//                    (_) in
//                    user.sendEmailVerification(completion: nil)
//                }
//                let alertActionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
//
//                alertVC.addAction(alertActionOkay)
//                alertVC.addAction(alertActionCancel)
//                parent.present(alertVC, animated: true, completion: nil)
//            } else {
//                if self.user != nil {
//                    validLogin = true
//                } else {
//                    print("User is nil in AppDelegate")
//                }
//            }
//        }
        return validLogin
    }
}
