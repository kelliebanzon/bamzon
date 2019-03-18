//
//  Team.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct Team: FirebaseCompatable, Equatable, Comparable {
    
    var teamID: ID
    var orgID: ID
    var userIDs: [ID: ID]
    var teamName: String
    var nextPractice: ID?
    var nextEvent: ID?
    var sport: String? // TODO: should sport be an optional?
    var joinReqIDs: [ID: ID]
    var blacklistUserIDs: [ID: ID]

    init(teamID: ID, orgID: ID, userIDs: [ID:ID], teamName: String, sport: String?, joinReqIDs: [ID: ID], blacklistUserIDs: [ID: ID]) {
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
        userIDs = IDUtility.stringsToIDDict(strs: payload["userIDs"] as? [String:String] ?? [:])
        teamName = payload["teamName"] as? String ?? "N/A"
        sport = payload["sport"] as? String
        joinReqIDs = IDUtility.stringsToIDDict(strs: payload["joinRequestIDs"] as? [String: String] ?? [:])
        blacklistUserIDs = IDUtility.stringsToIDDict(strs: payload["blacklistUserIDs"] as? [String: String] ?? [:])
        nextPractice = IDUtility.generateIDFromString(idString: payload["nextPractice"] as? String ?? "z0")
        nextEvent = IDUtility.generateIDFromString(idString: payload["nextEvent"] as? String ?? "z0")
    }
    
    static func < (lhs: Team, rhs: Team) -> Bool {
        return lhs.teamName < rhs.teamName
    }

    func formatForDB() -> [String: Any] {
        return
            ["blacklistUserIDs": IDUtility.idsToDict(ids: blacklistUserIDs),
             "joinRequestIDs": IDUtility.idsToDict(ids: joinReqIDs),
             "orgID": orgID.toString(),
             "sport": sport ?? "",
             "teamName": teamName,
             "userIDs": IDUtility.idsToDict(ids: userIDs)]
    }
    
    func getTable() -> FirTable {
        return FirTable.team
    }
    
    func getChildPath() -> String {
        return teamID.toString()
    }
}
