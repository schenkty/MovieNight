//
//  MovieViewController.swift
//  MovieNight
//
//  Created by Ty Schenk on 8/5/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MovieViewController: UICollectionViewController {

    var movies = [Movie]()
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = false
                
        setToolbar()
        getMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func getMovies() {
        MovieAPI.sharedInstance.getMovieSuggestions(page: currentPage) { movieResults, error in
            if let error = error {
                let alertController = MovieError.displayErrorWith(message: error.localizedDescription, handler: { alert in
                    self.getMovies()
                })
                self.present(alertController, animated: true, completion: nil)
            }
            
            if let movieResults = movieResults {
                self.movies = movieResults
                self.collectionView?.reloadData()
            }
        }
    }
    
    func setToolbar() {
        let startOverButton = UIBarButtonItem(title: "Start Over", style: .done, target: self, action: #selector(startOver(_:)))
        let leftSideSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let rightSideSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButtons = [leftSideSpace, startOverButton, rightSideSpace]
        self.setToolbarItems(barButtons, animated: false)
    }
    
    @IBAction func startOver(_ sender: Any) {
        MovieSessionManager.sharedManager.clearData()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let startVC = storyBoard.instantiateViewController(withIdentifier: "startView") as! StartViewController
        self.present(startVC, animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        
        cell.posterImage.image = nil
        cell.movie = movie
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
            
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
}
