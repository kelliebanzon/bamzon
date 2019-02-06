//
//  ID.swift
//  bamzon
//
//  Created by Kellie Banzon on 01/25/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ID : Codable, Hashable{
    var type: IdType
    var num: UInt
    
    var hashValue: Int {
        return type.hashValue * num.hashValue
    }
    
   /* func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(num)
    }
    
    init(from: Decoder) {
        
    }*/
    
    init(type: IdType, num: UInt){
        self.type = type
        self.num = num
    }
    
 /*   init(){
        type = IdType.other
        num = 0
        ref = nil
    }
    
    init(key: String, snapshot: DataSnapshot){
        let snapvalues = snapshot.value as! [String: AnyObject]
        let idString: String
        idString = snapvalues["id"] as? String ?? "o0"
        let id = IDUtility.generateIDFromString(idString: idString)
        
        self.type = id.type
        self.num = id.num
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "id" : type.rawValue + String(num)
        ]
    }*/
    
    func getString() -> String {
        return "\(type.rawValue)\(num)"
    }
}

func ==(lhs: ID, rhs: ID) -> Bool {
    return lhs.type == rhs.type && lhs.num == rhs.num
}

