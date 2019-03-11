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
        if team.joinReqIDs != nil {
            team.joinReqIDs!.append(self.user.userID)
        } else {
            team.joinReqIDs = [self.user.userID]
        }
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
    
    func loadTeamsWithOrg(dispatch: DispatchGroup, orgID: ID) {
        dispatch.enter()
        var org: Organization?
        DBUtility.readFromDB(table: FirTable.organization, keys: orgID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
            print("leave1")
            org = Organization(key: key, payload: payload)
            dispatch.leave()
        })
        print("wait1")
        dispatch.wait()
        
        for teamID in org!.teamIDs {
            print("enter")
            dispatch.enter()
            DBUtility.readFromDB(table: FirTable.organization, keys: teamID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
                self.teams.append(Team(key: key, payload: payload))
                print("leave")
                dispatch.leave()
            })
        }
        print("wait2")
        dispatch.wait()
    }
    
    func joinTeam(teamIndex: Int) {
        var team = teams[teamIndex]
        if team.userIDs != nil {
            team.userIDs!.append(self.user.userID)
        } else {
            team.userIDs = [self.user.userID]
        }
        DBUtility.writeToDB(objToWrite: team)
    }
}
