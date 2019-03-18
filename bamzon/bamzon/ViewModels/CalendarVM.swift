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
    var locStringDict: [ID: String] = [:] // event ID: Location Name
    
    func refresh() {
        for event in events {
            let dateString = event.date.toStringNoTZMinSec()
            var oldVal = self.eventDict[dateString]
            oldVal?.append(event)
            self.eventDict.updateValue(oldVal ?? [event], forKey: dateString)
            getLocationForEvent(event: event)
        }
    }
    
    func getEventsFor(dateStr: String) -> [Event] { //vc can access dates for a square by indexing with a string with format "yyyy-mm-dd"
        return eventDict[dateStr] ?? []
    }
    
    func getLocationForEvent(event: Event) -> String {
        if locStringDict[event.eventID] != nil {
            return locStringDict[event.eventID] ?? "Location not specified"
        }
        let dispatch = DispatchGroup()
        dispatch.enter()
        DBUtility.readFromDB(table: FirTable.location, keys: event.locationID ?? ID(type: "z", uuid: "000")) { (key: String, payload: [String : AnyObject]) in
            let loc = Location(key: key, payload: payload)
            print("query complete, location is: \(loc)")
            self.locStringDict[event.eventID] = loc.name
            dispatch.leave()
        }
        
        dispatch.notify(queue: DispatchQueue.main) {}
        
        return self.locStringDict[event.eventID] ?? "Location not specified"

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
