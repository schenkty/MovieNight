//
//  GenreViewController.swift
//  MovieNight
//
//  Created by Ty Schenk on 8/5/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit

class GenreViewController: UITableViewController {
    
    var genres = [Genre]()
    var selectedGenres = [Genre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGenres()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getGenres() {
        MovieAPI.sharedInstance.getGenres() { genres, error in
            if let error = error {
                let alertController = MovieError.displayErrorWith(message: error.localizedDescription, handler: { alert in
                    self.getGenres()
                })
                self.present(alertController, animated: true, completion: nil)
            }
            
            if let genres = genres {
                self.genres = genres
                self.tableView.reloadData()
            }
        }
    }
    
    func transitionToActorSelection() {
        let sessionManager = MovieSessionManager.sharedManager
        if sessionManager.sessionOne.isReady {
            sessionManager.sessionTwo.genres = self.selectedGenres
        } else {
            sessionManager.sessionOne.genres = self.selectedGenres
        }
        performSegue(withIdentifier: "selectActors", sender: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath) as! GenreCell
        
        let genre = genres[indexPath.row]
        cell.genreLabel.text = genre.name
        
        let isSelected = selectedGenres.index(where: { (testGenre) -> Bool in
            genre.id == testGenre.id
        })
        
        if isSelected != nil {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        if selectedGenres.count < 5 {
            selectedGenres.append(genres[indexPath.row])
            self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
            
            if selectedGenres.count == 5 {
                let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(transitionToActorSelection))
                self.navigationItem.rightBarButtonItem = nextButton
            }
            
            return indexPath
        }

        return nil
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedGenre = genres[indexPath.row]
        let selectedIndex = selectedGenres.index(where: { (genre) -> Bool in
            genre.id == selectedGenre.id
        })
        
        if let selectedIndex = selectedIndex {
            selectedGenres.remove(at: selectedIndex)
            self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        }
        
        if selectedGenres.count < 5 {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
}
