//
//  MovieCell.swift
//  MovieNight
//
//  Created by Ty Schenk on 8/5/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    var movie: Movie? {
        didSet {
            if let movie = movie {
                self.movieTitle.text = movie.title
                downloadImageFromURL(movie)
            }
        }
    }
    
    func downloadImageFromURL(_ movie: Movie) {
        MovieAPI.sharedInstance.getConfiguration { configuration, error in
            if error != nil {
                print("error: \(error)")
                return
            }
            
            guard let configuration = configuration else {
                fatalError("Got passed error logic with no configuration.")
            }
            
            let imageURL = URL(string: "\(configuration.secureBaseURL!)\(configuration.actorImageDirectory!)\(movie.posterImageURL)")!
            
            if movie.posterImage != nil {
                self.posterImage.image = movie.posterImage
            } else {
                let session = URLSession.shared
                let request = URLRequest(url: imageURL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
                let task = session.downloadTask(with: request) { location, response, error in
                    if error != nil {
                        return
                    }
                    
                    let imageData = try! Data(contentsOf: location!)
                    
                    let image = UIImage(data: imageData)
                    movie.posterImageState = .downloaded
                    movie.posterImage = image
                    
                    DispatchQueue.main.async {
                        self.posterImage.image = image
                    }
                }
                
                task.resume()
            }
        }
    }
}
