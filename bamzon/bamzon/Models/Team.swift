//
//  Team.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct Team: FirebaseCompatable, Equatable {
    
    var teamID: ID
    var orgID: ID
    var userIDs: [ID]?
    var teamName: String
    var nextPractice: ID?
    var nextEvent: ID?
    var sport: String? // TODO: should sport be an optional?
    var joinReqIDs: [ID]?
    var blacklistUserIDs: [ID]?

    init(teamID: ID, orgID: ID, userIDs: [ID]?, teamName: String, sport: String?, joinReqIDs: [ID]?, blacklistUserIDs: [ID]?) {
        self.teamID = teamID
        self.orgID = orgID
        self.userIDs = userIDs
        self.teamName = teamName
        self.sport = sport
        self.joinReqIDs = joinReqIDs
        self.blacklistUserIDs = blacklistUserIDs
        self.nextEvent = IDUtility.generateIDFromString(idString: "z0")
        self.nextPractice = IDUtility.generateIDFromString(idString: "z0")
    }
    
    //keys: teamID: ID
    init(key: String, payload: [String: AnyObject]) {
        teamID = IDUtility.generateIDFromString(idString: key)
        orgID = IDUtility.generateIDFromString(idString: payload["orgID"] as? String ?? "N/A")
        userIDs = IDUtility.stringsToIDs(strs: payload["userIDs"] as? [String] ?? [])
        teamName = payload["teamName"] as? String ?? "N/A"
        sport = payload["sport"] as? String
        joinReqIDs = IDUtility.stringsToIDs(strs: payload["joinRequestIDs"] as? [String] ?? [])
        blacklistUserIDs = IDUtility.stringsToIDs(strs: payload["blacklistUserIDs"] as? [String] ?? [])
        nextPractice = IDUtility.generateIDFromString(idString: payload["nextPractice"] as? String ?? "z0")
        nextEvent = IDUtility.generateIDFromString(idString: payload["nextEvent"] as? String ?? "z0")
    }

    func formatForDB() -> [String: Any] {
        return
            ["blacklistUserIDs": IDUtility.idsToStrings(ids: blacklistUserIDs),
             "joinRequestIDs": IDUtility.idsToStrings(ids: joinReqIDs),
             "orgID": orgID.toString(),
             "sport": sport ?? "",
             "teamName": teamName,
             "userIDs": IDUtility.idsToStrings(ids: userIDs)]
    }
    
    func getTable() -> FirTable {
        return FirTable.team
    }
    
    func getChildPath() -> String {
        return teamID.toString()
    }
}
