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
    fbDatabase.child(objToWrite.getTable()).child(objToWrite.getChildPath()).setValue(objToWrite.formatForDB())
    }
    
    // Event, PlayerStats, and Permissions requre two IDs to index
    static func readFromDB(table: String, keys: ID..., completion: @escaping (DataSnapshot) -> Void) {
        var keyArr = [String]()
        for key in keys {
            keyArr.append(key.asString())
        }
        
        let path = keyArr.joined(separator: "/")
        
        print("reading from \(table)/\(path)")
        fbDatabase.child(table).child(path).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                completion(snapshot)
            } else {
                print("Firebase Query Failed! No result found for key(s): \(path) in table: \(table)")
            }
        })
    }
    
    static func deleteFromDB(table: String, keys: ID...) {
        var keyArr = [String]()
        for key in keys {
            keyArr.append(key.asString())
        }
        
        let path = keyArr.joined(separator: "/")
        
        fbDatabase.child(table).child(path).removeValue()
    }
}
