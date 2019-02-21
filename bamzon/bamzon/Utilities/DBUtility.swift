//
//  DBUtility.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase

class DBUtility {
    
    static var fbDatabase = Database.database().reference()
    var fbImageDatabase: StorageReference!
    
    static func writeToDB(objToWrite: FirebaseCompatable) {
    fbDatabase.child(objToWrite.getTable().rawValue).child(objToWrite.getChildPath()).setValue(objToWrite.formatForDB())
    }
    
    /*  Fetches a model object from the database
    *
    *   table: FirTable => The name of the table you're trying to get an item from.
    *       Indexed by class name, eg. FirTable.joinRequest
    *   keys: the ID or IDs of the item you're looking for.
    *       All classes require a single ID, except for playerStats and playerPerms
    *   completion: a closure that takes a DataSnapshot and returns void. Usually used
    *       to assign an item to a variable. Returns when the asynchronous fetch is done.
    *
    *   Example:
    *
    *   readFromDB(FirTable.team, ID(type: IDType.team, num: 404), completion  {(snap:
    *       DataSnapshot) -> Void in
    *       var team = Team(snapshot: snap)})
    *
    *   keys:
    *       Event: event ID
    *       JoinRequest: join request ID
    *       Location: location ID
    *       Media: media ID
    *       Organization: org ID
    *       PlayerPerms: user ID, team ID
    *       PlayerStats: team ID, user ID
    *       RSVP: event ID
    *       Team: team ID
    *       TeamCalendar: team ID
    *       TeamStats: team ID
    *       User: user ID
    */
 
    static func readFromDB(table: FirTable, keys: ID..., completion: @escaping (DataSnapshot) -> Void) {
        var keyArr = [String]()
        for key in keys {
            keyArr.append(key.asString())
        }
        
        let path = keyArr.joined(separator: "/")
        
        print("reading from \(table)/\(path)")
        fbDatabase.child(table.rawValue).child(path).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                completion(snapshot)
            } else {
                print("Firebase Query Failed! No result found for key(s): \(path) in table: \(table.rawValue)")
            }
        })
    }
    
    static func deleteFromDB(table: FirTable, keys: ID...) {
        var keyArr = [String]()
        for key in keys {
            keyArr.append(key.asString())
        }
        
        let path = keyArr.joined(separator: "/")
        
        fbDatabase.child(table.rawValue).child(path).removeValue()
    }
}
