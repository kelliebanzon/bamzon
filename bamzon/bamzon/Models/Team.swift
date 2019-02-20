//
//  Team.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct Team: FirebaseCompatable {
    
    var teamID: ID
    var orgID: ID
    var userIDs: [ID]?
    var teamName: String
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
    }
    
    //keys: teamId: ID
    init(snapshot: DataSnapshot?) {
        let payload = snapshot?.value as? [String: AnyObject] ?? [:]
        teamID = IDUtility.generateIDFromString(idString: snapshot?.key ?? "z0")
        orgID = IDUtility.generateIDFromString(idString: payload["orgId"] as? String ?? "N/A")
        userIDs = IDUtility.stringsToIds(strs: payload["userIds"] as? [String] ?? [])
        teamName = payload["teamName"] as? String ?? "N/A"
        sport = payload["sport"] as? String
        stats = nil // these three are separate for now
        calendar = nil // todo connect with calendar/stats/joinRequest adapters
        joinReqIDs = IDUtility.stringsToIds(strs: payload["joinRequestIDs"] as? [String] ?? [])
        blacklistUserIDs = IDUtility.stringsToIds(strs: payload["blacklistUserIDs"] as? [String] ?? [])
        
        var thisTeam = self
       
        if teamID != ID(type: "z", num: 0) {
            DBUtility.readFromDB(table: FirTable.teamCalendar, keys: teamID, completion: {(tcSnap: DataSnapshot) -> Void in
                thisTeam.calendar = TeamCalendar(snapshot: tcSnap)
            })
            DBUtility.readFromDB(table: FirTable.teamStats, keys: teamID, completion: {(tsSnap: DataSnapshot) -> Void in
                thisTeam.stats = TeamStats(snapshot: tsSnap)
            })
        }
    }

    func formatForDB() -> [String: Any] {
        return
            ["blacklistUserIds": IDUtility.idsToStrings(ids: blacklistUserIDs),
             "joinRequestIds": IDUtility.idsToStrings(ids: joinReqIDs),
             "orgId": orgID.asString(),
             "sport": sport ?? "",
             "teamName": teamName,
             "userIds": IDUtility.idsToStrings(ids: userIDs)]
    }
    
    func getTable() -> FirTable {
        return FirTable.team
    }
    
    func getChildPath() -> String {
        return teamID.asString()
    }
}
