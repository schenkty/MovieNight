//
//  Movie.swift
//  MovieNight
//
//  Created by Ty Schenk on 8/5/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit

class Movie {
    let title: String
    let posterImageURL: String
    var posterImageState: ImageState
    var posterImage: UIImage?
    let id: String
    let genreIds: [Int]
    
    init(title: String, posterImageURL: String, id: String, genreIds: [Int]) {
        self.title = title
        self.posterImageURL = posterImageURL
        self.posterImageState = .placeholder
        self.id = id
        self.genreIds = genreIds
    }
}

extension Movie {
    convenience init?(from json: [String: AnyObject]) throws {
        guard let posterImageURL = json["poster_path"] as? String else {
            return nil
        }
        guard let title = json["title"] as? String,
            let id = json["id"] as? Int,
            let genreIds = json["genre_ids"] as? [Int] else {
                throw MovieError.jsonParsingError
        }
        
        self.init(title: title, posterImageURL: posterImageURL, id: String(id), genreIds: genreIds)
    }
}
