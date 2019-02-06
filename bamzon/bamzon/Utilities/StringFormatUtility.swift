//
//  StringFormatUtility.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation

extension Int {
    
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value: self))!
    }
    
    func minsAndSecs() -> String {
        let mins = Float(self) / 60000
        let minsInt = Int(mins.rounded(.down))
        let secs = Float(self - (minsInt*60000)) / 1000
        let secsInt = Int(secs.rounded(.down))
        if secsInt < 10 {
            return String(minsInt) + ":0" + String(secsInt)
        }
        else {
            return String(minsInt) + ":" + String(secsInt)
        }
    }
    
    func minsSecsMillisecs() -> String {
        // TODO: implement minsSecsMillisecs
        return ""
    }
    
}

/* This was added mainly for the substring fuction,
 * but I added entire utility in case we need it for anything else
 * Source:
 * https://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift-programming-language/38215613#38215613
 */
extension StringProtocol {
    
    subscript(offset: Int) -> Element {
        return self[index(startIndex, offsetBy: offset)]
    }
    
    subscript(_ range: CountableRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    subscript(range: CountableClosedRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    
    subscript(range: PartialRangeThrough<Int>) -> SubSequence {
        return prefix(range.upperBound.advanced(by: 1))
    }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence {
        return prefix(range.upperBound)
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence {
        return suffix(Swift.max(0, count - range.lowerBound))
    }
}
extension Substring {
    var string: String { return String(self) }
}
