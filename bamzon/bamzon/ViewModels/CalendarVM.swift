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
    var eventDict: [String: [Event]]
    
    init(teamID: ID, calendar: TeamCalendar) {
        self.teamID = teamID
        self.calendar = calendar
        self.eventDict = [:]
    }
    
    func refresh() {
        DBUtility.readAllChildrenFromDB(table: FirTable.event, keys: teamID, completion: {(eventSnap: [DataSnapshot]) -> Void in
                for event in eventSnap {
                    let event = Event(key: event.key, payload: event.value as? [String: AnyObject] ?? [:])
                    let dateString = "string"
                    var oldVal = self.eventDict[dateString]
//                    if oldVal == nil {
//                        self.eventDict.updateValue([event], forKey: dateString)
//                    } else {
//                        eventDict.updateValue(oldVal?.append(event) ?? [] as [Event], forKey: dateString)
//                    }
                }
            }
        )
    }
    
    func addEvent(event: Event) {
        DBUtility.writeToDB(objToWrite: event)
        if event.tags != nil {
            if event.tags!["practice"] != nil {
                let practice = Practice(teamID: event.teamID, event: event, users: [])
                DBUtility.writeToDB(objToWrite: practice)
            }
        }
    }
    
    func parseTags(tags: String) -> [String] {
        return tags.components(separatedBy: [" ", ","])
    }
    
    func updateEvents(events: [Event]) {
        calendar.setEvents(events: events)
        DBUtility.writeToDB(objToWrite: calendar)
    }
}
