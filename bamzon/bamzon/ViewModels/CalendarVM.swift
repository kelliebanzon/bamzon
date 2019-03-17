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
        DBUtility.readAllChildrenFromDB(table: FirTable.event, keys: team.teamID, completion: {(eventSnap: [DataSnapshot]) -> Void in
                for event in eventSnap {
                    let event = Event(key: event.key, payload: event.value as? [String: AnyObject] ?? [:])
                    let dateString = event.date.toString()
                    var oldVal = self.eventDict[dateString]
                    oldVal?.append(event)
                    self.eventDict.updateValue(oldVal ?? [event], forKey: dateString)
                }
            print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
            print(self.eventDict)
            }
        )
    }
    
    func getEventsFor(dateStr: String) -> [Event] { //vc can access dates for a square by indexing with a string with format "yyyy-mm-dd"
        return eventDict[dateStr] ?? []
    }
    
    func addEvent(event: Event) {
        DBUtility.writeToDB(objToWrite: event)
        if event.tags["practice"] != nil {
            let practice = Practice(teamID: event.teamID, eventID: event.eventID, users: [])
            DBUtility.writeToDB(objToWrite: practice)
        }
    }
    
    func parseTags(tags: String) -> [String] {
        return tags.components(separatedBy: [" ", ","])
    }
    
    func updateEvents(events: [Event]) {
//        team.calendar?.setEvents(events: events)
//        DBUtility.writeToDB(objToWrite: team.calendar ?? TeamCalendar(teamID: team.teamID, events: events)) TODO NEEDS SEPARATE CALENDAR
    }
}
