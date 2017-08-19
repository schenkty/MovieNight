//
//  MovieAPI.swift
//  MovieNight
//
//  Created by Ty Schenk on 8/5/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import Foundation
import Alamofire

class MovieAPI {
    var sessionManager: SessionManager
    
    private let movieAPIKey: String = "dac35790e3ef1f093794209adcae5352"
    private let langParam: String = "en-US"
    
    func getGenres(completion: @escaping ([Genre]?, Error?) -> Void) {
        var genreResults = [Genre]()

        sessionManager.request("https://api.themoviedb.org/3/genre/movie/list?api_key=\(movieAPIKey)&language=\(langParam)").responseJSON { response in
            guard let json = response.result.value as? [String: AnyObject],
                let genres = json["genres"] as? [[String: AnyObject]] else {
                completion(nil, response.error)
                return
            }
            
            do {
                for genreJSON in genres {
                    
                    if let parsedGenre = try Genre.init(from: genreJSON) {
                        genreResults.append(parsedGenre)
                    }
                }
                MovieSessionManager.sharedManager.genres = genreResults
                completion(genreResults, nil)
            } catch (let error) {
                completion(nil, error)
            }
        }
    }
    
    func getPopularActors(page: Int, completion: @escaping([Actor]?, Error?) -> Void) {
        var actorResults = [Actor]()
        let urlString = "https://api.themoviedb.org/3/person/popular?api_key=\(movieAPIKey)&language=\(langParam)&page=\(page)"
        
        sessionManager.request(urlString).responseJSON { response in
            guard let json = response.result.value as? [String: AnyObject],
                let actors = json["results"] as? [[String: AnyObject]] else {
                    completion(nil, response.error)
                    return
            }
            
            do {
                for actorJSON in actors {
                    if let actor = try Actor.init(with: actorJSON) {
                        actorResults.append(actor)
                    }
                }
                
                completion(actorResults, nil)
            } catch (let error) {
                completion(nil, error)
            }
        }
    }
    
    func getMovieSuggestions(page: Int, completion: @escaping([Movie]?, Error?) -> Void) {
        let session = MovieSessionManager.sharedManager
        var movieResults = [Movie]()
        
        let actorIds = session.getActorIDs()
        var actorIndex = 0
        let lastActorIndex = (actorIds.count - 1)
        var actorIdStr = ""
        
        for actorId in actorIds {
            if actorIndex == lastActorIndex {
                actorIdStr.append("\(actorId)")
            } else {
                actorIdStr.append("\(actorId)|")
            }
            
            actorIndex += 1
        }
        
        let genreIds = session.getGenreIDs()
        var genreIndex = 0
        let lastGenreIndex = genreIds.count
        var genreIdStr = ""
        
        for genreId in genreIds {
            if genreIndex == lastGenreIndex {
                genreIdStr.append("\(genreId)")
            } else {
                genreIdStr.append("\(genreId)|")
            }
            
            genreIndex += 1
        }
        
            
        let parameters: Parameters = [
            "api_key": movieAPIKey,
            "language": langParam,
            "with_people": actorIdStr,
            "with_genres": genreIdStr,
            "sort_by": "popularity.desc",
            "include_adult": "false",
            "include_video": "false",
            "page": page
        ]
            
        sessionManager.request("https://api.themoviedb.org/3/discover/movie", parameters: parameters).responseJSON { response in
            guard let json = response.result.value as? [String: AnyObject],
                let movies = json["results"] as? [[String: AnyObject]] else {
                    completion(nil, response.error)
                    return
            }
            
            do {
                for movieJSON in movies {
                    if let movie = try Movie.init(from: movieJSON) {
                        movieResults.append(movie)
                    }
                }
                
                completion(movieResults, nil)
            } catch (let jsonError) {
                
                completion(nil, jsonError)
            }
        }
    }
    
    func getConfiguration(completion: @escaping(Configuration?, Error?) -> Void) {
        sessionManager.request("https://api.themoviedb.org/3/configuration?api_key=\(movieAPIKey)").responseJSON { response in
            guard let json = response.result.value as? [String: AnyObject] else {
                completion(nil, response.error)
                return
            }
            
            let configuration = Configuration.init(with: json)
            
            completion(configuration, nil)
        }
    }
    
    static let sharedInstance = MovieAPI()
    
    private init() {
        let configuration = URLSessionConfiguration.ephemeral
        self.sessionManager = Alamofire.SessionManager(configuration: configuration, delegate: SessionDelegate(), serverTrustPolicyManager: nil)
    }
}
