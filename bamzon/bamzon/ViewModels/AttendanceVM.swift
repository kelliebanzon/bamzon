//
//  AttendanceVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

//Players, list of practices (tagged events).

class AttendanceVM: LoggedInViewModel {
    
    var members: [User] = []
    var practices: [Event] = [] //list of practices
    
    func refresh(dispatch: DispatchGroup) {
        loadPractices(dispatch: dispatch)
    }
    
    func loadAttendance(dispatch: DispatchGroup) {
        loadPlayers(dispatch: dispatch)
        loadPractices(dispatch: dispatch)
    }
    
    func loadPlayers(dispatch: DispatchGroup) {
        if let userIDs = self.team.userIDs {
            for userID in userIDs {
                dispatch.enter()
                DBUtility.readFromDB(table: FirTable.user, keys: userID, completion: { (key: String, userSnap: [String: AnyObject]) -> Void in
                    self.members.append(User(key: key, payload: userSnap))
                    dispatch.leave()
                })
            }
        }
    }
    
    func loadPractices(dispatch: DispatchGroup) {
        var tempEvent: Event?
        if let events = self.team.calendar?.getEvents() {
            for event in events {
                dispatch.enter()
                print("looking at event")
                DBUtility.readFromDB(table: FirTable.event, keys: event.eventID, completion: { (key: String, userSnap: [String: AnyObject]) -> Void in
                    tempEvent = Event(key: key, payload: userSnap)
                    if tempEvent!.tags?["practice"] != nil {
                        print("found practice")
                        self.practices.append(Event(key: key, payload: userSnap))
                    }
                    dispatch.leave()
                })
            }
        }
    }
    
    func loadAttendance(player: User) {
        //TODO: implement update attendance
    }
}
