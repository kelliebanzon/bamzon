//
//  CreateTeamVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

class CreateTeamVM {
    
    var allOrgs: [Organization] = []
    
    //TODO: create function for existing org and new org.
    func createTeam(teamName: String, org: Organization, sport: String) {
        let teamID = IDUtility.generateTeamID()
        
        //TODO: Check if the org name exists already. not sure where we wanna do this but it should be done somewhere and someow.
        //TODO: comment out write to database
        //let orgID = IDUtility.generateOrgID()
        
        // swiftlint:disable force_cast
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // swiftlint:enable force_cast
        if var user = appDelegate.curUser {
            let team = Team.init(teamID: teamID, orgID: org.orgID, userIDs: [user.userID], teamName: teamName, sport: sport, stats: nil, calendar: nil, joinReqIDs: nil, blacklistUserIDs: nil)
            if user.teamIDs == nil {
                user.teamIDs = [teamID]
            } else {
                user.teamIDs!.append(teamID)
            }
            
            var newOrg = org
            newOrg.teamIDs.append(teamID)
            
            appDelegate.curUser = user
            DBUtility.writeToDB(objToWrite: appDelegate.curUser!)
            DBUtility.writeToDB(objToWrite: newOrg)
            DBUtility.writeToDB(objToWrite: team)
        } else {
            print("an error has occurred creating team")
        }
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
    
}
