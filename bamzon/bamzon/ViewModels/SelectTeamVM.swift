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
    var organizations: [Organization] = [] //correspond to matching index in teams array

    var waitForTeam = true
    var waitForOrg = true
    
    func refresh(parent: UIViewController) {
        loadTableValues(parent: parent)
    }
    
    func loadTableValues(parent: UIViewController) {
        if self.user.teamIDs != nil && self.user.teamIDs!.count != 0 {
            for teamID in self.user.teamIDs! {
                print("team1")
                let team = getTeam(teamID: teamID, parent: parent)
                teams.append(team)
                organizations.append(getOrg(orgID: team.orgID))
            }
            
        }
    }

    func getTeam(teamID: ID, parent: UIViewController) -> Team {
        var team: Team?
        DBUtility.readFromDB(table: FirTable.team, keys: teamID, completion: { (key: String, teamSnap: [String: AnyObject]) -> Void in
            parent.removeSpinner()
            team = Team(key: key, payload: teamSnap)
            //self.waitForTeam = false
        })
        while waitForTeam {print("\(self.teams.count)")}
        return team!
    }

    func getOrg(orgID: ID) -> Organization {
        // TODO: return the organization object with a given orgID. code below is temporary for testing purposes
        var org: Organization?
        DBUtility.readFromDB(table: FirTable.organization, keys: orgID, completion: { (key: String, orgSnap: [String: AnyObject]) -> Void in
            org = Organization(key: key, payload: orgSnap)
            self.waitForOrg = false
        })
        
        while self.waitForOrg {print("waiting2")}
        return org!

    }
    
    func selectTeam(team: Team) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.curTeam = team
        }
    }
    
}
