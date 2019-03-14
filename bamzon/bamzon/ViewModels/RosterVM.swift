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
        dispatch.enter()
        DBUtility.readFromDB(table: FirTable.team, keys: self.team.teamID, completion: { (key: String, teamSnap: [String: AnyObject]) -> Void in
            let newTeam = Team(key: key, payload: teamSnap)
            if newTeam.userIDs != nil {
                self.getUsers(userIDs: newTeam.userIDs!, dispatch: dispatch)
            }
            dispatch.leave()
        })
    }
    
    //TODO: move userID to the VM and access from VC
    func getUsers(userIDs: [ID], dispatch: DispatchGroup) {
        for userID in userIDs {
            dispatch.enter()
            DBUtility.readFromDB(table: FirTable.user, keys: userID, completion: { (key: String, userSnap: [String: AnyObject]) -> Void in
                self.members.append(User(key: key, payload: userSnap))
                dispatch.leave()
            })
        }
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
