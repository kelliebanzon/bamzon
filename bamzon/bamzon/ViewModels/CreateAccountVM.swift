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
    
    var creationErrorMessage: String?
    
    func sendVerification(completion: @escaping(UIAlertController?) -> Void) {
        //TODO: Customize verification email
        // You can customize the email template that is used in Authentication section of the Firebase console, on the Email Templates page. See Email Templates in Firebase Help Center:
        //https://support.google.com/firebase/answer/7000714
        if checkUserEmailVerified() {
            let alertController = UIAlertController(title: "Already Verified", message: "User email already verified", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            completion(alertController)
        } else {
            Auth.auth().currentUser?.sendEmailVerification { (error) in
                if error != nil {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    completion(alertController)
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
    
    /* create account in firebase
     * add account info to firebase object in initUser()
     * Initialize local User object, and pass up to parent vc
     */
    func createAccount(fname: String, lname: String, email: String, password: String, dispatch: DispatchGroup) {
        dispatch.enter()
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if error == nil {
                guard let user = authResult?.user else { return }
                let newUser = self.initUser(fname: fname, lname: lname, email: email)
                let firebaseID = FirebaseID(userID: newUser.userID, firebaseID: user.uid)
                DBUtility.writeToDB(objToWrite: firebaseID)
                DBUtility.writeToDB(objToWrite: newUser)
            } else {
                self.creationErrorMessage = error!.localizedDescription
            }
            dispatch.leave()
        }
    }
    
    func initUser(fname: String, lname: String, email: String) -> User {
        let newUserID = IDUtility.generateUserID()
        let newUser = User.init(userID: newUserID, firstName: fname, lastName: lname, nickname: String(fname + " " + lname), phone: nil, email: nil, schoolYear: nil, bio: nil, imageURL: nil, teamIDs: nil)
        return newUser
    }
}
