//
//  Media.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import Firebase

struct Media: FirebaseCompatable, Equatable {
    var url: String // TODO: should this be a URL?
    var mediaID: ID
    
    init(url: String, mediaID: ID) {
        self.url = url
        self.mediaID = mediaID
    }
    
    init(key: String, payload: [String: AnyObject]) {
        url = payload["url"] as? String ?? "N/A"
        mediaID = IDUtility.generateIDFromString(idString: key)
    }
    
    func formatForDB() -> [String: Any] {
        return ["url": url]
    }
    
    func getTable() -> FirTable {
        return FirTable.media
    }
    
    func getChildPath() -> String {
        return mediaID.toString()
    }
}
