//
//  RSVP.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct RSVP: FirebaseCompatable {
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
    
    init(snapshot: DataSnapshot?) {
        let payload = snapshot?.value as? [String: AnyObject] ?? [:]
        eventID = IDUtility.generateIDFromString(idString: snapshot?.key ?? "z0")
        yesUserIDs = IDUtility.stringsToIds(strs: payload["yesUserIds"] as? [String] ?? [])
        pendingUserIDs = IDUtility.stringsToIds(strs: payload["pendingUserIds"] as? [String] ?? [])
        noUserIDs = IDUtility.stringsToIds(strs: payload["noUserIds"] as? [String] ?? [])
    }
    
    func formatForDB() -> [String: Any] {
        return
            ["yesUserIds": IDUtility.idsToStrings(ids: yesUserIDs ?? []),
             "noUserIds": IDUtility.idsToStrings(ids: noUserIDs ?? []),
             "pendingUserIds": IDUtility.idsToStrings(ids: pendingUserIDs ?? [])]
    }
    
    func getTable() -> String {
        return "RSVPs"
    }
    
    func getChildPath() -> String {
        return eventID.asString()
    }
    
}
