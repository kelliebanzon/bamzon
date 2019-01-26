//
//  ID.swift
//  bamzon
//
//  Created by Kellie Banzon on 01/25/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation

class ID: Codable {
    var type: String
    var num: UInt
    
    init(type: String, num: UInt){
        self.type = type
        self.num = num
    }
}
