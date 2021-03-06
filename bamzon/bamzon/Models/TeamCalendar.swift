//
//  TeamCalendar.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct TeamCalendar: FirebaseCompatable, Equatable {
    var eventIDs: [ID]?
    var teamID: ID

    init(teamID: ID, eventIDs: [ID]?) {
        self.eventIDs = eventIDs
        self.teamID = teamID
    }
    
    init(key: String, payload: [String: AnyObject]) {
        teamID = IDUtility.generateIDFromString(idString: key)
        eventIDs = IDUtility.stringsToIDs(strs: payload["eventIDs"] as? [String] ?? [])
    }
    
    func formatForDB() -> [String: Any] {
        let idStrings = IDUtility.idsToStrings(ids: eventIDs ?? [])
        var toWrite: AnyObject
        
        if (idStrings.isEmpty) {
            toWrite = ["e404"] as AnyObject
        } else {
            toWrite = idStrings as AnyObject
        }
        
        return ["eventIDs": toWrite]
    }
    
    func getTable() -> FirTable {
        return FirTable.teamCalendar
    }
    
    func getChildPath() -> String {
        return teamID.toString()
    }
}
