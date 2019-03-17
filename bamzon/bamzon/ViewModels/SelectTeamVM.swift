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
    
    func refresh(dispatch: DispatchGroup) {
        loadTeams(dispatch: dispatch)
    }
    
    func loadTeams(dispatch: DispatchGroup) {
        teams.removeAll()
        organizations.removeAll()
        for teamID in self.user.teamIDs {
            loadTeam(teamID: teamID.key, dispatch: dispatch)
        }
        
    }

    func loadTeam(teamID: ID, dispatch: DispatchGroup) {
        dispatch.enter()
        DBUtility.readFromDB(table: FirTable.team, keys: teamID, completion: { (key: String, teamSnap: [String: AnyObject]) -> Void in
            let team = Team(key: key, payload: teamSnap)
            self.teams.append(team)
            self.loadOrg(orgID: team.orgID, dispatch: dispatch)
            dispatch.leave()
        })
    }

    func loadOrg(orgID: ID, dispatch: DispatchGroup) {
        dispatch.enter()
        DBUtility.readFromDB(table: FirTable.organization, keys: orgID, completion: { (key: String, orgSnap: [String: AnyObject]) -> Void in
            let org = Organization(key: key, payload: orgSnap)
            self.organizations.append(org)
            dispatch.leave()
        })
    }
    
    func selectTeam(team: Team) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.curTeam = team
        }
    }
    
}
