//
//  TeamStats.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct TeamStats: FirebaseCompatable {
    var teamID: ID
    var memberCount: Int
    var wins: Int
    var losses: Int
    var ties: Int
    var fields: [String: Any]?
    
    init(teamID: ID, memberCount: Int, wins: Int, losses: Int, ties: Int, fields: [String: Any]?) {
        self.teamID = teamID
        self.memberCount = memberCount
        self.wins = wins
        self.losses = losses
        self.ties = ties
        self.fields = fields
    }
    
    init(snapshot: DataSnapshot?) {
        let payload = snapshot?.value as? [String: Any] ?? [:]
        teamID = IDUtility.generateIDFromString(idString: snapshot?.key ?? "z0")
        memberCount = payload["memberCount"] as? Int ?? 0
        wins = payload["wins"] as? Int ?? 0
        losses = payload["losses"] as? Int ?? 0
        ties = payload["ties"] as? Int ?? 0
        fields = payload["fields"] as? [String: Any] ?? [:]
    }
    
    func formatForDB() -> [String: Any] {
        return
            ["memberCount": memberCount,
             "wins": wins,
             "losses": losses,
             "fields": fields ?? [:],
             "ties": ties]
    }
    
    func getTable() -> FirTable {
        return FirTable.teamStats
    }
    
    func getChildPath() -> String {
        return teamID.asString()
    }
    
}
