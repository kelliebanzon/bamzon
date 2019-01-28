//
//  Media.swift
//  bamzon
//
//  Created by Kellie Banzon on 12/02/18.
//  Copyright © 2018 bamzon. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Media {
    var url: String // TODO: should this be a URL?
    let ref: DatabaseReference?
    
    init(url: String){
        self.url = url
        ref = nil
    }
    
    init(){
        url = "N/A"
        ref = nil
    }
    
    init(key: String, snapshot: DataSnapshot){        
        let snapvalues = snapshot.value as! [String : AnyObject]
        url = snapvalues["url"] as? String ?? "N/A"
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "url" : url
        ]
    }
}
