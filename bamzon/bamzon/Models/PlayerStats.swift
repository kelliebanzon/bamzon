//
//  PlayerStats.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import FirebaseDatabase

class PlayerStats {
    var fields: [String: Any]?
    let ref : DatabaseReference?
    
    init(fields: [String: Any]?){
        self.fields = fields
        ref = nil
    }
    
    init(){
        fields = [:]
        ref = nil
    }
    
    init(key: String, snapshot: DataSnapshot){
        for field in (snapshot.childSnapshot(forPath: "fields").children.allObjects as! [DataSnapshot]) {
            fields![field.key] = field.value
        }
        
        ref = snapshot.ref
        
    }
    
    func toAnyObject() -> Any {
        return [fields]
    }
}
