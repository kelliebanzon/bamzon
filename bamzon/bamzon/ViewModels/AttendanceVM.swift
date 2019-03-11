//
//  AttendanceVM.swift
//  bamzon
//
//  Created by Krein, Kevin on 12/2/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

//Players, list of practices (tagged events).

class Attendace: LoggedInViewModel {
    
    var members: [User] = []
    var practies: [Event] = [] //list of practices
    
    
    func refresh() {
        //TODO: implement refresh
    }
    
    func updatePlayers(parent: DisplayableProtocol) {
        if let userIDs = self.team.userIDs {
            for userId in userIDs {
                DBUtility.readFromDB(table: FirTable.user, keys: userId, completion: { (key: String, userSnap: [String: AnyObject]) -> Void in
                    self.members.append(User(key: key, payload: userSnap))
                    parent.display()
                })
            }
        }
    }
    
    func updatePractices(parent: DisplayableProtocol) {
        var tempEvent: Event? = nil
        if let userIDs = self.team.userIDs {
            for userId in userIDs {
                DBUtility.readFromDB(table: FirTable.user, keys: userId, completion: { (key: String, userSnap: [String: AnyObject]) -> Void in
                    tempEvent = Event(key: key, payload: userSnap)
                    if(tempEvent!.tags?["practice"] != nil) {
                        self.practies.append(Event(key: key, payload: userSnap))
                    }
                    parent.display()
                })
            }
        }
    }
    
    func updateAttendance(player: User) {
        //TODO: implement update attendance
    }
}
