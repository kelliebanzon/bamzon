//
//  JoinRequestsVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/4/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

//List of users

class JoinRequestsVM: LoggedInViewModel {
    
    var reqUsers: [User] = []
    
    func refresh(dispatch: DispatchGroup) {
        loadRequests(dispatch: dispatch)
    }
    
    //TODO: Check for duplicates within join requests. Spam join request shouldn't be allowed
    @objc func approve(reqIndex: Int) {
        let userID = reqUsers[reqIndex].userID
        self.team.joinReqIDs.removeValue(forKey: userID)
        self.team.userIDs[userID] = userID
        
        reqUsers.remove(at: reqIndex)
        DBUtility.writeToDB(objToWrite: self.team)
        DBUtility.readFromDB(table: FirTable.user, keys: userID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
            var user = User(key: key, payload: payload)
            user.teamIDs[self.team.teamID] = self.team.teamID
            DBUtility.writeToDB(objToWrite: user)
        })
    }
    
    func reject(reqIndex: Int) {
        self.team.joinReqIDs.removeValue(forKey: reqUsers[reqIndex].userID)
        reqUsers.remove(at: reqIndex)
        DBUtility.writeToDB(objToWrite: self.team)
    }
    
    func block(reqIndex: Int) {
        self.team.joinReqIDs.removeValue(forKey: reqUsers[reqIndex].userID)
        self.team.blacklistUserIDs[reqUsers[reqIndex].userID] = reqUsers[reqIndex].userID
        reqUsers.remove(at: reqIndex)
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
    
    func loadRequests(dispatch: DispatchGroup) {
        self.reqUsers.removeAll()
        reloadTeam(dispatch: dispatch)
        dispatch.notify(queue: DispatchQueue.main) {
            for userID in Array(self.team.joinReqIDs.values) {
                dispatch.enter()
                DBUtility.readFromDB(table: FirTable.user, keys: userID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
                    self.reqUsers.append(User(key: key, payload: payload))
                    dispatch.leave()
                })
            }
        }
    }
}
