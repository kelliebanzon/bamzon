//
//  RSVP.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct RSVP {
    var yesUserIDs: [ID]?
    var noUserIDs: [ID]?
    var pendingUserIDs: [ID]?
    let ref: DatabaseReference?
    
    init(yesUserIDs: [ID]?, noUserIDs: [ID]?, pendingUserIDs: [ID]?){
        self.yesUserIDs = yesUserIDs
        self.noUserIDs = noUserIDs
        self.pendingUserIDs = pendingUserIDs
        ref = nil
    }
    
    init(){
        ref = nil
    }
    
    init(key: String, snapshot: DataSnapshot){
        let snapvalues = snapshot.value as! [String : AnyObject]
        
        for yesUserID in (snapshot.childSnapshot(forPath:
            "yesUserIDs").children.allObjects as! [DataSnapshot]) {
                yesUserIDs!.append(ID(key: yesUserID.key, snapshot: yesUserID))
        }
        
        for noUserID in (snapshot.childSnapshot(forPath:
            "noUserIDs").children.allObjects as! [DataSnapshot]) {
                noUserIDs!.append(ID(key: noUserID.key, snapshot: noUserID))
        }
        
        for pendingUserID in (snapshot.childSnapshot(forPath:
            "pendingUserIDs").children.allObjects as! [DataSnapshot]) {
                pendingUserIDs!.append(ID(key: pendingUserID.key, snapshot: pendingUserID))
        }
        
    }
    
    
}
