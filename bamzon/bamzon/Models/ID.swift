//
//  ID.swift
//  bamzon
//
//  Created by Kellie Banzon on 01/25/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation

class ID: Codable, Hashable {
    var type: String
    var uuid: String
    
    var hashValue: Int {
        return type.hashValue * uuid.hashValue
    }
    
    init(type: String, uuid: String) {
        self.type = type
        self.uuid = uuid
    }
    
    func asString() -> String {
        return "\(type)\(uuid)"
    }

}

func == (lhs: ID, rhs: ID) -> Bool {
    return lhs.type == rhs.type && lhs.uuid == rhs.uuid
}
