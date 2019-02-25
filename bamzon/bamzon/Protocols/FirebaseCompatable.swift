//
//  FirebaseAdaptProtocol.swift
//  bamzon
//
//  Created by Daniel Heyde on 2/7/19.
//  Copyright © 2019 bamzon. All rights reserved.
//

import Foundation
import Firebase

protocol FirebaseCompatable {
    // writes object to db reference
    init (key: String, payload: [String: AnyObject])
    func formatForDB() -> [String: Any]
    func getTable() -> FirTable
    func getChildPath() -> String
}

