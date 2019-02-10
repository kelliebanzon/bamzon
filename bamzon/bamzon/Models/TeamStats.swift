//
//  TeamStats.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

struct TeamStats {
    
    var memberCount: Int
    var wins: Int
    var losses: Int
    var ties: Int
    var fields: [String: Any]?
    
    init(memberCount: Int, wins: Int, losses: Int, ties: Int, fields: [String: Any]?) {
        self.memberCount = memberCount
        self.wins = wins
        self.losses = losses
        self.ties = ties
        self.fields = fields
    }
}
