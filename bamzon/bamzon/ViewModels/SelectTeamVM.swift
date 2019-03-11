//
//  SelectTeamVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import UIKit

// List of teams for user

class SelectTeamVM: LoggedInViewModel {
    
    var teams: [Team] = []

    func loadTeams(parent: DisplayableProtocol) {
        if(self.user.teamIDs != nil && self.user.teamIDs!.count != 0) {
            for teamID in self.user.teamIDs! {
                DBUtility.readFromDB(table: FirTable.team, keys: teamID, completion: { (key: String, teamSnap: [String: AnyObject]) -> Void in
                    self.teams.append(Team(key: key, payload: teamSnap))
                    parent.display()
                })
            }
        }
    }
    
    func refresh(parent: DisplayableProtocol) {
        loadTeams(parent: parent)
    }

    func getTeamsForCurUser() -> [Team] {
        // TODO: get the list of teams associated with the current user. all of the code below are hard-coded values which should be deleted
        return [Team(teamID: IDUtility.generateTeamID(), orgID: IDUtility.generateOrgID(), userIDs: [IDUtility.generateUserID()], teamName: "Swim Club", sport: "Swim", stats: nil, calendar: nil, joinReqIDs: nil, blacklistUserIDs: nil)]
    }

    func getOrg(orgID: ID) -> Organization {
        // TODO: return the organization object with a given orgID. code below is temporary for testing purposes
        return Organization(orgID: IDUtility.generateOrgID(), name: "Cal Poly", location: nil, teamIDs: [team.teamID])
    }
    
    func selectTeam(team: Team) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.curTeam = team
        }
    }
    
}
