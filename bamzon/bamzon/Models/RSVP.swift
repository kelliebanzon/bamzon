//
//  RSVP.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct RSVP: FirebaseCompatable, Equatable {
    var yesUserIDs: [ID]?
    var noUserIDs: [ID]?
    var pendingUserIDs: [ID]?
    var eventID: ID
    
    init(eventID: ID, yesUserIDs: [ID]?, noUserIDs: [ID]?, pendingUserIDs: [ID]?) {
        self.eventID = eventID
        self.yesUserIDs = yesUserIDs
        self.noUserIDs = noUserIDs
        self.pendingUserIDs = pendingUserIDs
    }
    
    init(key: String, payload: [String: AnyObject]) {
        eventID = IDUtility.generateIDFromString(idString: key)
        yesUserIDs = IDUtility.stringsToIDs(strs: payload["yesUserIDs"] as? [String] ?? [])
        pendingUserIDs = IDUtility.stringsToIDs(strs: payload["pendingUserIDs"] as? [String] ?? [])
        noUserIDs = IDUtility.stringsToIDs(strs: payload["noUserIDs"] as? [String] ?? [])
    }
    
    func formatForDB() -> [String: Any] {
        return
            ["yesUserIDs": IDUtility.idsToStrings(ids: yesUserIDs ?? []),
             "noUserIDs": IDUtility.idsToStrings(ids: noUserIDs ?? []),
             "pendingUserIDs": IDUtility.idsToStrings(ids: pendingUserIDs ?? [])]
    }
    
    func getTable() -> FirTable {
        return FirTable.rsvp
    }
    
    func getChildPath() -> String {
        return eventID.toString()
    }
    
}
