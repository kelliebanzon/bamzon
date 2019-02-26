//
//  RosterVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

class RosterVM: ViewModel {
    func refresh(rosterVC: RosterVC, teamID: ID) {
        DBUtility.readFromDB(table: FirTable.team, keys: teamID, completion: { (key: String, teamSnap: [String: AnyObject]) -> Void in
            let newTeam = Team(key: key, payload: teamSnap)
            if newTeam.userIDs != nil {
                rosterVC.team = newTeam
                rosterVC.members = self.getUsers(userIDs: newTeam.userIDs!)
            }
            rosterVC.display()
        })
    }
    
    func getUsers(userIDs: [ID]) -> [User] {
        var members = [User]()
        for id in userIDs {
            DBUtility.readFromDB(table: FirTable.user, keys: id, completion: { (key: String, userSnap: [String: AnyObject]) -> Void in
                members.append(User(key: key, payload: userSnap))
            })
        }
        return members
    }
    
    func updateRoster(roster: [User]) {
        //TODO: implement update roster
    }
}
