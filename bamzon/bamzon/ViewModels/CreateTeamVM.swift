//
//  CreateTeamVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

class CreateTeamVM: ViewModel {
    
    var team: Team?
    
    func createTeam(teamName: String, orgName: String, sport: String) {
        let teamID = IDUtility.generateTeamID()
        //TODO: Check if the org name exists already. not sure where we wanna do this but it should be done somewhere and someow.
        //TODO: comment out write to database
        let orgID = IDUtility.generateOrgID()
        
        self.team = Team.init(teamID: teamID, orgID: orgID, userIDs: nil, teamName: teamName, sport: sport, stats: nil, calendar: nil, joinReqIDs: nil, blacklistUserIDs: nil)
        //DBUtility.writeToDB(objToWrite: team)
    }
}
