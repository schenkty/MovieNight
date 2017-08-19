//
//  Genre.swift
//  MovieNight
//
//  Created by Ty Schenk on 8/5/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import Foundation

class Genre {
    let name: String
    let id: Int
    
    init(name: String, id: Int) {
        self.name = name
        self.id   = id
    }
}

extension Genre {
    convenience init?(from json: [String: AnyObject]) throws {
        guard let name = json["name"] as? String,
            let id = json["id"] as? Int else {
                throw MovieError.jsonParsingError
        }
        
        self.init(name: name, id: id)
    }
}
