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
    var eventDict: [String: [Event]] = [:]
    
    func refresh() {
        for event in events {
            let dateString = event.date.toStringNoTZMinSec()
            var oldVal = self.eventDict[dateString]
            oldVal?.append(event)
            self.eventDict.updateValue(oldVal ?? [event], forKey: dateString)
        }
    }
    
    func getEventsFor(dateStr: String) -> [Event] { //vc can access dates for a square by indexing with a string with format "yyyy-mm-dd"
        return eventDict[dateStr] ?? []
    }
    
    func addEvent(event: Event) {
        DBUtility.writeToDB(objToWrite: event)
        if event.tags["practice"] != nil {
            let practice = Practice(teamID: self.team.teamID, eventID: event.eventID, date: event.date
                , attendingUsers: [:], excusedUsers: [:])
            DBUtility.writeToDB(objToWrite: practice)
        }
    }
    
    func parseTags(tags: String) -> [String] {
        return tags.components(separatedBy: [" ", ","])
    }
    
    func updateEvents(events: [Event]) {
        self.events = events

        let eventIDs = events.map({(event) -> ID in
            return event.eventID
        })
        
        calendar?.eventIDs = eventIDs
        DBUtility.writeToDB(objToWrite: calendar ?? TeamCalendar(teamID: team.teamID, eventIDs: eventIDs))
    }
}
