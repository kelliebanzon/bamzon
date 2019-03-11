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

class SelectTeamVM: ViewModel {
    func refresh() {
        //TODO: implement refresh teams to select
    }

    func getTeamsForCurUser() -> [Team] {
        // TODO: get the list of teams associated with the current user. all of the code below are hard-coded values which should be deleted
        return [Team(teamID: IDUtility.generateTeamID(), orgID: IDUtility.generateOrgID(), userIDs: [IDUtility.generateUserID()], teamName: "Swim Club", sport: "Swim", stats: nil, calendar: nil, joinReqIDs: nil, blacklistUserIDs: nil)]
    }

    func getOrg(orgID: ID) -> Organization {
        // TODO: return the organization object with a given orgID. code below is temporary for testing purposes
        return Organization(orgID: IDUtility.generateOrgID(), name: "Cal Poly", location: nil, teamIDs: [team?.teamID ?? IDUtility.generateIDFromString(idString: "t404")])
    }
    
    func selectTeam(selectedTeamID: ID) {
        // @ kevin: connect this to the database so it pulls the appropriate team down
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            //appDelegate.curTeam = selectedTeam
        }
    }
    
}
