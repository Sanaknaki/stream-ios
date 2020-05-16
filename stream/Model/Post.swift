//
//  Poset.swift
//  stream
//
//  Created by Ali Sanaknaki on 2020-05-16.
//  Copyright © 2020 Ali Sanaknaki. All rights reserved.
//

struct Post {

    var id: String?
    
    var stream: String
    var time: String
    
    init(dictionary: [String: Any]) {
        self.stream = dictionary["stream"] as? String ?? ""
        self.time = dictionary["time"] as? String ?? ""
    }
}

