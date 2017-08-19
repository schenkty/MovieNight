//
//  ActorViewController.swift
//  MovieNight
//
//  Created by Ty Schenk on 8/5/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit

class ActorViewController: UITableViewController {

    var actors = [Actor]()
    var selectedActors = [Actor]()
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getActors()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func getActors() {
        MovieAPI.sharedInstance.getPopularActors(page: currentPage) { actors, error in
            if let error = error {
                let alertController = MovieError.displayErrorWith(message: error.localizedDescription, handler: { alert in
                    self.getActors()
                })
                self.present(alertController, animated: true, completion: nil)
                return
            }
            
            if let actors = actors {
                self.actors = actors
                self.tableView.reloadData()
            }
        }
    }
    
    func nextScreen() {
        let sessionManager = MovieSessionManager.sharedManager
        if MovieSessionManager.sharedManager.sessionOne.isReady {
            sessionManager.sessionTwo.actors = self.selectedActors
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let startVC = storyBoard.instantiateViewController(withIdentifier: "startView") as! StartViewController
            self.present(startVC, animated: true, completion: nil)
        } else {
            sessionManager.sessionOne.actors = self.selectedActors
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let startVC = storyBoard.instantiateViewController(withIdentifier: "startView") as! StartViewController
            self.present(startVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actorCell", for: indexPath) as! ActorCell
        let actor = actors[indexPath.row]
        
        cell.headshotImageView.image = nil
        cell.actor = actor
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        if selectedActors.count < 5 {
            selectedActors.append(actors[indexPath.row])
            self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
            
            if selectedActors.count == 5 {
                let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextScreen))
                self.navigationItem.rightBarButtonItem = nextButton
            }
            
            return indexPath
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedActor = actors[indexPath.row]
        let selectedIndex = selectedActors.index(where: { (actor) -> Bool in
            actor.id == selectedActor.id
        })
        
        if let selectedIndex = selectedIndex {
            selectedActors.remove(at: selectedIndex)
            self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
        }
        
        if selectedActors.count < 5 {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
}
