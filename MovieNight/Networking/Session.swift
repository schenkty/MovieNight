//
//  Session.swift
//  MovieNight
//
//  Created by Ty Schenk on 8/5/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import Foundation

class Session {
    var genres = [Genre]()
    var actors = [Actor]()
    var isReady: Bool {
        return !self.genres.isEmpty && !self.actors.isEmpty
    }
    
    func clearData() {
        genres.removeAll()
        actors.removeAll()
    }
}
