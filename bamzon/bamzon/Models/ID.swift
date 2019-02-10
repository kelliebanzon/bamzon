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
    var num: UInt
    
    var hashValue: Int {
        return type.hashValue * num.hashValue
    }
    
    init(type: String, num: UInt) {
        self.type = type
        self.num = num
    }
}

func == (lhs: ID, rhs: ID) -> Bool {
    return lhs.type == rhs.type && lhs.num == rhs.num
}
