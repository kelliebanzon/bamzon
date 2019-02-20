//
//  TeamCalendar.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct TeamCalendar: FirebaseCompatable {
    var events: [Event]
    var teamID: ID

    init(teamID: ID, events: [Event]) {
        self.events = events
        self.teamID = teamID
    }
    
    init(snapshot: DataSnapshot?) {
        let payload = snapshot?.value as? [String: AnyObject] ?? [:]
        teamID = IDUtility.generateIDFromString(idString: snapshot?.key ?? "z0")
        let eventIDs = payload["eventIds"] as? [String] ?? []
        events = []
    
        var thisCalendar = self
        
        if eventIDs.isEmpty {
            for eIDString in eventIDs {
                let eventID = IDUtility.generateIDFromString(idString: eIDString)
                DBUtility.readFromDB(table: FirTable.location, keys: eventID, completion: {(eventSnap: DataSnapshot) -> Void in
                thisCalendar.events.append(Event(snapshot: eventSnap))
                print("event location fetch succeeded: calendar is \(thisCalendar)")
                })
            }
        } else {
            print("no location to fetch for calendar \(teamID.asString())")
        }
    }
    
    func formatForDB() -> [String: Any] {
        var eventIDList = [ID]()
        for event in events {
            eventIDList.append(event.eventID)
        }
        return ["events": IDUtility.idsToStrings(ids: eventIDList)]
    }
    
    func getTable() -> FirTable {
        return FirTable.teamCalendar
    }
    
    func getChildPath() -> String {
        return teamID.asString()
    }
}
