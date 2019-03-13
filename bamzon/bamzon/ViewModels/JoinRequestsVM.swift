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
    
    var requestedUsers: [User] = []
    
    //TODO: Check for duplicates within join requests. Spam join request shouldn't be allowed
    func approve(requestIndex: Int) {
        self.team.joinReqIDs!.remove(at: requestIndex)
        if self.team.userIDs != nil {
            self.team.userIDs!.append(requestedUsers[requestIndex].userID)
        } else {
            self.team.userIDs = [requestedUsers[requestIndex].userID]
        }
        requestedUsers.remove(at: requestIndex)
        DBUtility.writeToDB(objToWrite: self.team)
    }
    
    func reject(requestIndex: Int, dispatch: DispatchGroup) {
        self.team.joinReqIDs!.remove(at: requestIndex)
        requestedUsers.remove(at: requestIndex)
        DBUtility.writeToDB(objToWrite: self.team)
    }
    
    func loadRequests(dispatch: DispatchGroup) {
        if self.team.joinReqIDs != nil {
            for userID in self.team.joinReqIDs! {
                dispatch.enter()
                DBUtility.readFromDB(table: FirTable.user, keys: userID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
                    self.requestedUsers.append(User(key: key, payload: payload))
                    dispatch.leave()
                })
            }
        }
        
    }
}
