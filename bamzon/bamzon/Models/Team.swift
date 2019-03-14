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
    var stats: TeamStats?
    var calendar: TeamCalendar?
    var joinReqIDs: [ID]?
    var blacklistUserIDs: [ID]?

    init(teamID: ID, orgID: ID, userIDs: [ID]?, teamName: String, sport: String?, stats: TeamStats?, calendar: TeamCalendar?, joinReqIDs: [ID]?, blacklistUserIDs: [ID]?) {
        self.teamID = teamID
        self.orgID = orgID
        self.userIDs = userIDs
        self.teamName = teamName
        self.sport = sport
        self.stats = stats
        self.calendar = calendar
        self.joinReqIDs = joinReqIDs
        self.blacklistUserIDs = blacklistUserIDs
        self.nextEvent = nil
        self.nextPractice = nil
    }
    
    //keys: teamID: ID
    init(key: String, payload: [String: AnyObject]) {
        teamID = IDUtility.generateIDFromString(idString: key)
        orgID = IDUtility.generateIDFromString(idString: payload["orgID"] as? String ?? "N/A")
        userIDs = IDUtility.stringsToIDs(strs: payload["userIDs"] as? [String] ?? [])
        teamName = payload["teamName"] as? String ?? "N/A"
        sport = payload["sport"] as? String
        stats = nil // these three are separate for now
        calendar = nil // todo connect with calendar/stats/joinRequest adapters
        joinReqIDs = IDUtility.stringsToIDs(strs: payload["joinRequestIDs"] as? [String] ?? [])
        blacklistUserIDs = IDUtility.stringsToIDs(strs: payload["blacklistUserIDs"] as? [String] ?? [])
        nextPractice = IDUtility.generateIDFromString(idString: payload["nextPractice"] as? String ?? "z0")
        nextEvent = IDUtility.generateIDFromString(idString: payload["nextEvent"] as? String ?? "z0")
        
        var thisTeam = self
        
        if teamID != ID(type: "z", uuid: "0") {
            DBUtility.readFromDB(table: FirTable.teamCalendar, keys: teamID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
                thisTeam.calendar = TeamCalendar(key: key, payload: payload)
            })
            DBUtility.readFromDB(table: FirTable.teamStats, keys: teamID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
                thisTeam.stats = TeamStats(key: key, payload: payload)
            })
        }

    }

    func formatForDB() -> [String: Any] {
        return
            ["blacklistUserIDs": IDUtility.idsToStrings(ids: blacklistUserIDs),
             "joinRequestIDs": IDUtility.idsToStrings(ids: joinReqIDs),
             "orgID": orgID.asString(),
             "sport": sport ?? "",
             "teamName": teamName,
             "userIDs": IDUtility.idsToStrings(ids: userIDs)]
    }
    
    func getTable() -> FirTable {
        return FirTable.team
    }
    
    func getChildPath() -> String {
        return teamID.asString()
    }
}
