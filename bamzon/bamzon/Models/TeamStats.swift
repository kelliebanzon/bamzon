//
//  TeamStats.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import FirebaseDatabase

class TeamStats {
    
    var memberCount: Int
    var wins: Int
    var losses: Int
    var ties: Int
    var fields: [String: Any]?
    var ref: DatabaseReference?
    
    init(memberCount: Int, wins: Int, losses: Int, ties: Int, fields: [String: Any]?) {
        self.memberCount = memberCount
        self.wins = wins
        self.losses = losses
        self.ties = ties
        self.fields = fields
        ref = nil
        
    }
    
    init(){
        memberCount = 0
        wins = 0
        losses = 0
        ties = 0
        ref = nil
    }
    
    init(key: String, snapshot: DataSnapshot){
        
        let snapvalues = snapshot.value as! [String : AnyObject]
        
        memberCount = snapvalues["memberCount"] as? Int ?? 0
        wins = snapvalues["wins"] as? Int ?? 0
        losses = snapvalues["losses"] as? Int ?? 0
        ties = snapvalues["ties"] as? Int ?? 0
        
        for field in (snapshot.childSnapshot(forPath: "fields").children.allObjects as! [DataSnapshot]) {
            fields![field.key] = field.value
        }
        
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "memberCount" : memberCount,
            "wins" : wins,
            "losses" : losses,
            "ties" : ties,
            "fields" : [fields]
        ]
    }
    
}
