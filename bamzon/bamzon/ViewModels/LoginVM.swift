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
    
    var errorMessage: String?
    var isEmailVerified = false
    
    func checkLogin(dispatch: DispatchGroup, email: String?, password: String?) {
        print("checking login")
        
        guard let email = email, let password = password else {
            self.errorMessage = "Please enter a valid input."
            return
        }
        dispatch.enter()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print("error")
                self.errorMessage = error?.localizedDescription ?? "Error signing in."
            } else {
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    dispatch.enter()
                    DBUtility.readFromDB(table: FirTable.firebaseID, keys: user!.user.uid, completion: {(key: String, payload: [String: AnyObject]) -> Void in
                        
                        let userID = payload["userID"] as? String ?? ""
                        
                        dispatch.enter()
                        DBUtility.readFromDB(table: FirTable.user, keys: userID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
                            appDelegate.curUser = User(key: key, payload: payload)
                            dispatch.leave()
                        })
                        dispatch.leave()
                    })
                }
            }
            dispatch.leave()
        }
    }
    
    func loadEmailVerified(dispatch: DispatchGroup) {
        //citing sources: https://stackoverflow.com/questions/38061203/how-to-verify-a-users-email-address-on-ios-with-firebase/38406024
        if let user = Auth.auth().currentUser {
            dispatch.enter()
            user.reload { (_) in
                self.isEmailVerified = user.isEmailVerified
                dispatch.leave()
            }
        }
    }
}
