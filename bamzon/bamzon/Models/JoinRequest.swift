//
//  JoinRequest.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct JoinRequest {
    var user: User
    var team: Team
    let ref: DatabaseReference?
    
    init(user: User, team: Team){
        self.user = user
        self.team = team
        ref = nil
    }
    
    init(){
        user = User()
        team = Team()
        ref = nil
    }
    
    init(key: String, snapshot: DataSnapshot){
        let snapvalues = snapshot.value as! [String : AnyObject]        
        user = snapvalues["user"] as? User ?? User()
        team = snapvalues["team"] as? Team ?? Team()
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "user" : user,
            "team" : team
        ]
    }
    
}
