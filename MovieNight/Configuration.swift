//
//  Configuration.swift
//  MovieNight
//
//  Created by Ty Schenk on 8/5/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import Foundation

class Configuration {
    var secureBaseURL: String?
    var actorImageDirectory: String?
    var posterImageDirectory: String?
    
    init(secureBaseURL: String, actorImageDirectory: String, posterImageDirectory: String) {
        self.secureBaseURL = secureBaseURL
        self.actorImageDirectory = actorImageDirectory
        self.posterImageDirectory = posterImageDirectory
    }
}

extension Configuration {
    convenience init?(with json: [String: AnyObject]) {
        
        guard let imageInfo = json["images"] as? [String: AnyObject] else {
            print("*************************")
            print("Failed to parse imageInfo")
            print(json["images"])
            return nil
        }
        
        guard let secureBaseURL = imageInfo["secure_base_url"] as? String else {
            print("*************************")
            print("Failed to parse secure_base_url")
            print(imageInfo["secure_base_url"])
            return nil
        }
        
        guard let actorImageDirectories = imageInfo["profile_sizes"] as? [String] else {
            print("*************************")
            print("Failed to parse actorImageDirectories")
            print(imageInfo["profile_sizes"])
            return nil
        }
        
        guard let posterImageDirectories = imageInfo["poster_sizes"] as? [String] else {
            print("*************************")
            print("Failed to parse posterImageDirectories")
            print(imageInfo["poster_sizes"])
            return nil
        }
        
        self.init(secureBaseURL: secureBaseURL, actorImageDirectory: actorImageDirectories[2], posterImageDirectory: posterImageDirectories[2])
    }
}
