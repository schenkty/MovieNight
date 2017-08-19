//
//  StartViewController.swift
//  MovieNight
//
//  Created by Ty Schenk on 8/18/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var userButtonOne: UIButton!
    @IBOutlet weak var userButtonTwo: UIButton!
    @IBOutlet weak var resultsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsButton.isHidden = true
        
        if MovieSessionManager.sharedManager.sessionOne.isReady {
            userButtonOne.setImage(#imageLiteral(resourceName: "bubble-selected"), for: .normal)
            userButtonOne.isUserInteractionEnabled = false
            userButtonTwo.isUserInteractionEnabled = true
        } else {
            userButtonOne.setImage(#imageLiteral(resourceName: "bubble-empty"), for: .normal)
            userButtonOne.isUserInteractionEnabled = true
            userButtonTwo.isUserInteractionEnabled = false
        }
        
        if MovieSessionManager.sharedManager.sessionTwo.isReady {
            userButtonTwo.setImage(#imageLiteral(resourceName: "bubble-selected"), for: .normal)
            resultsButton.isHidden = false
            userButtonOne.isUserInteractionEnabled = false
            userButtonTwo.isUserInteractionEnabled = false
        } else {
            userButtonTwo.setImage(#imageLiteral(resourceName: "bubble-empty"), for: .normal)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewResults(_ sender: UIButton) {
        performSegue(withIdentifier: "displayMovies", sender: nil)
    }
}
