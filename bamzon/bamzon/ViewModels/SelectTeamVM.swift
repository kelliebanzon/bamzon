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
    
    func refresh(parent: UIViewController, teamVC: SelectTeamVC) {
        loadTableValues(parent: parent, teamVC: teamVC)
    }
    
    func loadTableValues(parent: UIViewController, teamVC: SelectTeamVC) {
        if self.user.teamIDs != nil && self.user.teamIDs!.count != 0 {
            for teamID in self.user.teamIDs! {
                getTeam(teamID: teamID, parent: parent, teamVC: teamVC)
            }
            
        }
    }

    func getTeam(teamID: ID, parent: UIViewController, teamVC: SelectTeamVC){
        DBUtility.readFromDB(table: FirTable.team, keys: teamID, completion: { (key: String, teamSnap: [String: AnyObject]) -> Void in
            parent.removeSpinner()
            let team = Team(key: key, payload: teamSnap)
            self.teams.append(team)
            var orgLoaded = false
            for teamOrg in self.organizations {
                if teamOrg.orgID == team.orgID {
                    orgLoaded = true
                }
            }
            if !orgLoaded {
                self.getOrg(orgID: team.orgID, teamVC: teamVC)
            }
            teamVC.display()
        })
    }

    func getOrg(orgID: ID, teamVC: SelectTeamVC) {
        DBUtility.readFromDB(table: FirTable.organization, keys: orgID, completion: { (key: String, orgSnap: [String: AnyObject]) -> Void in
            let org = Organization(key: key, payload: orgSnap)
            self.organizations.append(org)
            teamVC.display()
        })
    }
    
    func selectTeam(team: Team) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.curTeam = team
        }
    }
    
}
