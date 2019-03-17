//
//  ID.swift
//  bamzon
//
//  Created by Kellie Banzon on 01/25/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation

class ID: Codable, Hashable, CustomStringConvertible {
    var type: String
    var uuid: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(uuid)
    }
    
    init(type: String, uuid: String) {
        self.type = type
        self.uuid = uuid
    }
    
    func toString() -> String {
        return "\(type)\(uuid)"
    }
    
    var description: String {
        return self.toString()
    }
}

func == (lhs: ID, rhs: ID) -> Bool {
    return lhs.type == rhs.type && lhs.uuid == rhs.uuid
}
