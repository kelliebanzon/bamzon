//
//  FirebaseID.swift
//  bamzon
//
//  Created by Kevin Krein on 2/25/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation

struct FirebaseID: FirebaseCompatable, Equatable {
    var userID: ID
    var firebaseID: String
    
    init(userID: ID, firebaseID: String) {
        self.userID = userID
        self.firebaseID = firebaseID
    }
    
    init(key: String, payload: [String:AnyObject]) {
        userID = IDUtility.generateIDFromString(idString: payload["userID"] as? String ?? "")
        firebaseID = key
    }

    func formatForDB() -> [String:Any] {
        return ["userID": userID.asString()]
    }
    
    func getTable() -> FirTable {
        return FirTable.firebaseID
    }
    
    func getChildPath() -> String {
        return firebaseID
    }
    
}
