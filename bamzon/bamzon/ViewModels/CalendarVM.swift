//
//  CalendarVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

class CalendarVM: ViewModel {
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

    func updateEvents(events: [Event]) {
        calendar.events = events
        DBUtility.writeToDB(objToWrite: calendar)
    }
}
