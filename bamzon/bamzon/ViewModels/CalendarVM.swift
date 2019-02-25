//
//  CalendarVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

class CalendarVM {
    let teamID: ID
    var calendar: TeamCalendar
    
    init(teamID: ID, calendar: TeamCalendar) {
        self.teamID = teamID
        self.calendar = calendar;
    }
    
    func refresh() {
        DBUtility.readAllChildrenFromDB(table: FirTable.event, keys: teamID, completion: {(eventSnap: [DataSnapshot]) -> Void in
            for event in eventSnap {
                self.calendar.events.append(Event(key: event.key as? String ?? "z0", payload: event.value as? [String: AnyObject] ?? [:]))}
            }
        )
    }

    //Uhhhhhh
    func updateEvents(events: [Event]) {
        //TODO: implement update Events
    }
}
