//
//  TeamHomeVM.swift
//  bamzon
//
//  Created by liblabs-mac on 3/13/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
//event objects

class TeamHomeVM: LoggedInViewModel {
    
    var nextPractice: Event?
    var nextNonPractice: Event?
    
    func refresh(dispatch: DispatchGroup) {
//        dispatch.enter()
//        DBUtility.readFromDB(table: FirTable.event, keys: self.team.nextPractice ?? ID(type: "x", uuid: "0"), completion: {(key: String, payload: [String: AnyObject]) -> Void in
//            self.nextPractice = Event(key: key, payload: payload)
//                dispatch.leave()
//        })
//        dispatch.enter()
//        DBUtility.readFromDB(table: FirTable.event, keys: self.team.nextEvent ?? ID(type: "x", uuid: "0"), completion: {(key: String, payload: [String: AnyObject]) -> Void in
//            self.nextNonPractice = Event(key: key, payload: payload)
//            dispatch.leave()
//        })
    }
}
