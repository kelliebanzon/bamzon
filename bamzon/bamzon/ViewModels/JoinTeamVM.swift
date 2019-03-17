//
//  JoinTeamVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

//List of orgnizations
//Pull selected organization's list of teams

class JoinTeamVM: LoggedInViewModel {
    var allOrgs: [Organization] = []
    var teams: [Team] = []
    
    func sendJoinRequest(teamIndex: Int) {
        var team = teams[teamIndex]
        team.joinReqIDs[self.user.userID] = self.user.userID

        DBUtility.writeToDB(objToWrite: team)
    }
    
    func loadOrgs(dispatch: DispatchGroup) {
        dispatch.enter()
        DBUtility.readBaseFromDB(table: FirTable.organization, completion: {(snapshot: [DataSnapshot]) -> Void in
            for org in snapshot {
                self.allOrgs.append(Organization(key: org.key, payload: org.value as? [String: AnyObject] ?? [:]))
            }
            dispatch.leave()
        })
    }
    
    func loadOrg(dispatch: DispatchGroup, orgID: ID) {
        dispatch.enter()
        var org: Organization?
        DBUtility.readFromDB(table: FirTable.organization, keys: orgID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
            org = Organization(key: key, payload: payload)
            dispatch.leave()
        })
        
        dispatch.notify(queue: DispatchQueue.main) {
            self.loadTeamsWithOrg(dispatch: dispatch, org: org!)
        }
    }
    
    func loadTeamsWithOrg(dispatch: DispatchGroup, org: Organization) {
        for teamID in org.teamIDs {
            dispatch.enter()
            DBUtility.readFromDB(table: FirTable.team, keys: teamID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
                self.teams.append(Team(key: key, payload: payload))
                dispatch.leave()
            })
        }
    }
    
    func joinTeam(teamIndex: Int) {
        var team = teams[teamIndex]
        team.userIDs[self.user.userID] = self.user.userID
        DBUtility.writeToDB(objToWrite: team)
    }
}
