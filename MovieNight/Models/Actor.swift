//
//  Actor.swift
//  MovieNight
//
//  Created by Ty Schenk on 8/5/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit

class Actor {
    let name: String
    let id: Int
    let profileImageURL: String
    var profileImageState: ImageState
    var profileImage: UIImage?
    
    init(name: String, id: Int, profileImageURL: String) {
        self.name = name
        self.id = id
        self.profileImageURL = profileImageURL
        self.profileImageState = ImageState.placeholder
    }
}

extension Actor {
    convenience init?(with json: [String: AnyObject]) throws {
        guard let name = json["name"] as? String,
            let id = json["id"] as? Int,
            let profileImageURL = json["profile_path"] as? String else {
                throw MovieError.jsonParsingError
        }
        
        self.init(name: name, id: id, profileImageURL: profileImageURL)
    }
}
