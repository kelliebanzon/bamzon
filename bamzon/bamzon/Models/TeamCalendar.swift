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
    private var events: [Event]
    var teamID: ID

    init(teamID: ID, events: [Event]) {
        self.events = events
        self.teamID = teamID
        self.events.sort()
    }
    
    init(key: String, payload: [String: AnyObject]) {
        teamID = IDUtility.generateIDFromString(idString: key)
        let eventIDs = payload["eventIDs"] as? [String] ?? []
        events = []
        print ("event IDS in teamcalendar are: \(eventIDs)")
    
        var thisCalendar = self
        
        if !eventIDs.isEmpty {
            for eIDString in eventIDs {
                let eventID = IDUtility.generateIDFromString(idString: eIDString)
                DBUtility.readFromDB(table: FirTable.event, keys: eventID, completion: {(key: String, payload: [String: AnyObject]) -> Void in
                    thisCalendar.events.append(Event(key: key, payload: payload))
                print("event event fetch succeeded: calendar is \(thisCalendar)")
                })
            }
        } else {
            print("no event to fetch for calendar \(teamID.asString())")
        }
    }
    
    func getEvents() -> [Event] {
        return events
    }
    
    mutating func addEvent(event: Event) {
        events.append(event)
        events.sort()
    }
    
    mutating func setEvents(events: [Event]) {
        self.events = events
        self.events.sort()
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
