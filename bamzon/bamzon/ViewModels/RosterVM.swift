//
//  RosterVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

var members = [User]()

class RosterVM: ViewModel {
    func refresh(rosterVC: RosterVC, teamID: ID) {
        DBUtility.readFromDB(table: FirTable.team, keys: teamID, completion: { (key: String, teamSnap: [String: AnyObject]) -> Void in
            let newTeam = Team(key: key, payload: teamSnap)
            if newTeam.userIDs != nil {
                rosterVC.team = newTeam
                self.getUsers(userIDs: newTeam.userIDs!, rosterVC: rosterVC)
            }
        })
    }
    
    func getUsers(userIDs: [ID], rosterVC: RosterVC) {
        rosterVC.members = [User]()
        for userId in userIDs {
            DBUtility.readFromDB(table: FirTable.user, keys: userId, completion: { (key: String, userSnap: [String: AnyObject]) -> Void in
                rosterVC.members.append(User(key: key, payload: userSnap))
                rosterVC.display()
            })
        }
    }
    
    func updateRoster(roster: [User]) {
//        userIDs = rosterToIDList(roster: roster)
//            
//            
//            for usr in roster {
//                usr.teamIDs?.append()
//            }
        }
    
    
    func rosterToIDList(roster: [User]) -> [ID] {
        var rosterIDs = [ID]()
        for usr in roster {
            rosterIDs.append(usr.userID)
        }
        return rosterIDs
    }
}
