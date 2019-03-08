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
    
    func checkLogin(email: String, password: String) -> String? {
        var toReturn: String?
        //TODO: fix this so it isn't always false
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                toReturn = error?.localizedDescription
            } else {
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate { DBUtility.readFromDB(table: FirTable.firebaseIDs, keys: user!.user.uid, completion: {(key: String, payload: [String: AnyObject]) -> Void in
                        appDelegate.curUser = User(key: key, payload: payload)
                    })
                }

            }
        }
        return toReturn
    }
}
