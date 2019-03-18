//
//  StatsVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

//Current player
//list of all players on current team (roster)
//team stats

class StatsVM: LoggedInViewModel {
    
    var members: [User] = []
    var teamStats: TeamStats?
    
    func loadMembers(dispatch: DispatchGroup) {
        self.members.removeAll()
        for userID in Array(self.team.userIDs.values) {
            dispatch.enter()
            DBUtility.readFromDB(table: FirTable.user, keys: userID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
                self.members.append(User(key: key, payload: payload))
                dispatch.leave()
            })
        }
    }
    
    func loadTeamStats(dispatch: DispatchGroup) {
        dispatch.enter()
        DBUtility.readFromDB(table: FirTable.teamStats, keys: self.team.teamID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
            self.teamStats = TeamStats(key: key, payload: payload)
            dispatch.leave()
        })
    }
}
