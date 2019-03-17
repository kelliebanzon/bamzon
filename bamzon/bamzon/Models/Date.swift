//
//  Date.swift
//  bamzon
//
//  Created by Daniel Heyde on 3/13/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm Z"
        return dateFormatter.string(from: self)
    }
    
    static func fromString(from: String) -> Date {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd hh:mm Z"
        return formatter.date(from: from) ?? Date(timeIntervalSince1970: -3600)
    }
    
    func toStringNoTZMinSec() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    static func fromStringNoTZMinSec(from: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: from) ?? Date(timeIntervalSince1970: -3600)
    }
}
