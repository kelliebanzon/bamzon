//
//  BlockedUserVM.swift
//  bamzon
//
//  Created by Kevin Krein on 3/17/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation

class BlockedUsersVM: LoggedInViewModel {
    
    var blockedUsers: [User] = []
    
    func refresh(dispatch: DispatchGroup) {
        loadBlocked(dispatch: dispatch)
    }
    
    func unblock(blockedIndex: Int) {
        self.team.blacklistUserIDs.removeValue(forKey: blockedUsers[blockedIndex].userID)
        blockedUsers.remove(at: blockedIndex)
        DBUtility.writeToDB(objToWrite: self.team)
    }
    
    func reloadTeam(dispatch: DispatchGroup) {
        dispatch.enter()
        DBUtility.readFromDB(table: FirTable.team, keys: self.team.teamID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
            let reloadedTeam = Team(key: key, payload: payload)
            self.team = reloadedTeam
            self.appDelegate.curTeam = reloadedTeam
            dispatch.leave()
        })
    }
    
    func loadBlocked(dispatch: DispatchGroup) {
        self.blockedUsers.removeAll()
        reloadTeam(dispatch: dispatch)
        dispatch.notify(queue: DispatchQueue.main) {
            for userID in Array(self.team.blacklistUserIDs.values) {
                dispatch.enter()
                DBUtility.readFromDB(table: FirTable.user, keys: userID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
                    self.blockedUsers.append(User(key: key, payload: payload))
                    dispatch.leave()
                })
            }
        }
    }
}
