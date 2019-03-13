//
//  SettingsVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

//log out

class SettingsVM: LoggedInViewModel {
    
    func updateSettings() {
        //TODO: implement update settings
    }

    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("failed to sign out")
        }
        self.appDelegate.curUser = nil
    }
}
