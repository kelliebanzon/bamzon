//
//  RosterVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

class RosterVM: LoggedInViewModel {
    
    var members = [User]()
    
    func refresh(dispatch: DispatchGroup) {
        loadUsers(dispatch: dispatch)
    }
    
    func loadUsers(dispatch: DispatchGroup) {
        print("users: \(users)")
        members = users
    }
    
    func rosterToIDList(roster: [User]) -> [ID] {
        var rosterIDs = [ID]()
        for usr in roster {
            rosterIDs.append(usr.userID)
        }
        return rosterIDs
    }
    
    func selectUser(user: User) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.curUser = user
        }
    }
}
