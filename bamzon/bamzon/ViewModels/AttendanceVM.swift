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
    var practices: [Practice] = [] //list of practices
    var selectedPractice: Practice?
    
    func refreshCurrentPractice(dispatch: DispatchGroup) {
        loadAttendance(dispatch: dispatch)
    }
    
    func refreshPractices(dispatch: DispatchGroup) {
        loadPractices(dispatch: dispatch)
    }
    
    func loadAttendance(dispatch: DispatchGroup) {
        loadPlayers(dispatch: dispatch)
        dispatch.notify(queue: DispatchQueue.main) {
            self.loadPractices(dispatch: dispatch)
        }
    }
    
    func loadPlayers(dispatch: DispatchGroup) {
        self.members.removeAll()
        for userID in self.team.userIDs {
            dispatch.enter()
            DBUtility.readFromDB(table: FirTable.user, keys: userID.key, completion: { (key: String, userSnap: [String: AnyObject]) -> Void in
                self.members.append(User(key: key, payload: userSnap))
                dispatch.leave()
            })
        }
        
    }
    
    func loadPractices(dispatch: DispatchGroup) {
        for event in events {
            dispatch.enter()
            print("looking at event")
            DBUtility.readFromDB(table: FirTable.practice, keys: team.teamID, event.eventID, completion: { (key: String, userSnap: [String: AnyObject]) -> Void in
                let tempPractice = Practice(key: key, payload: userSnap)
                if tempPractice.date < Date() {
                    self.practices.append(tempPractice)
                }
                dispatch.leave()
            })
        }
    }
    
    func getTodayPractice(dispatch: DispatchGroup) {
        print("Well, shit grandma")
        for practice in practices {
            print("Fuck")
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone.current
            formatter.dateFormat = "yyyy-MM-dd"
            if formatter.string(from: practice.date) == formatter.string(from: Date.init()) {
                selectedPractice = practice
                return
            }
        }
    }
    
    
    func markPresent(userIndex: Int) {
        selectedPractice!.attendingUsers[users[userIndex].userID] = users[userIndex].userID
        DBUtility.writeToDB(objToWrite: selectedPractice!)
    }
    
    func markExcused(userIndex: Int) {
        selectedPractice!.excusedUsers[users[userIndex].userID] = users[userIndex].userID
        DBUtility.writeToDB(objToWrite: selectedPractice!)
    }
    
    func markAbsent(userIndex: Int) {
        selectedPractice!.attendingUsers.removeValue(forKey: users[userIndex].userID)
        selectedPractice!.excusedUsers.removeValue(forKey: users[userIndex].userID)
        DBUtility.writeToDB(objToWrite: selectedPractice!)
    }
    
    func loadAttendance(player: User) {
        //TODO: implement update attendance
    }
}
