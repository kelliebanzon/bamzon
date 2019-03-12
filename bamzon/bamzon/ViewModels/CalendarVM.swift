//
//  CalendarVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

class CalendarVM: LoggedInViewModel {
    let teamID: ID
    var calendar: TeamCalendar
    
    init(teamID: ID, calendar: TeamCalendar) {
        self.teamID = teamID
        self.calendar = calendar
    }
    
    func refresh() {
        DBUtility.readAllChildrenFromDB(table: FirTable.event, keys: teamID, completion: {(eventSnap: [DataSnapshot]) -> Void in
            for event in eventSnap {
                self.calendar.events.append(Event(key: event.key, payload: event.value as? [String: AnyObject] ?? [:]))}
            }
        )
    }
    
    func addEvent(event: Event) {
        DBUtility.writeToDB(objToWrite: event)
        if event.tags != nil {
            if event.tags!["practice"] != nil {
                let practice = Practice(teamID: event.teamID, eventID: event.eventID, users: [])
                DBUtility.writeToDB(objToWrite: practice)
            }
        }
    }
    
    func parseTags(tags: String) -> [String] {
        return tags.components(separatedBy: [" ", ","])
    }
    
    func updateEvents(events: [Event]) {
        calendar.events = events
        DBUtility.writeToDB(objToWrite: calendar)
    }
}
