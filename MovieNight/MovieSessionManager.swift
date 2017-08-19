//
//  MovieSessionManager.swift
//  MovieNight
//
//  Created by Ty Schenk on 8/5/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import Foundation

class MovieSessionManager {
    let sessionOne = Session()
    let sessionTwo = Session()
    var genres: [Genre]?
    
    static let sharedManager = MovieSessionManager()
    private init() {}
    
    func getActorIDs() -> [Int] {
        let sessionOneActors = self.sessionOne.actors.map { (actor: Actor) -> Int in
            return actor.id
        }
        
        let sessionTwoActors = self.sessionTwo.actors.map { (actor: Actor) -> Int in
            return actor.id
        }
        
        return sessionOneActors + sessionTwoActors
    }
    
    func getGenreIDs() -> [Int] {
        let sessionOneGenres = self.sessionOne.genres.map { (genre: Genre) -> Int in
            return genre.id
        }
        
        let sessionTwoGenres = self.sessionTwo.genres.map { (genre: Genre) -> Int in
            return genre.id
        }
        
        return sessionOneGenres + sessionTwoGenres
    }
    
    func clearData() {
        sessionOne.clearData()
        sessionTwo.clearData()
    }
}
