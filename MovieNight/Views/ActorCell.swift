//
//  ActorCell.swift
//  MovieNight
//
//  Created by Ty Schenk on 8/5/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit

class ActorCell: UITableViewCell {

    @IBOutlet weak var headshotImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var actor: Actor? {
        didSet {
            if let actor = actor {
                self.nameLabel.text = actor.name
                downloadProfilePictureFor(actor)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func downloadProfilePictureFor(_ actor: Actor) {
        MovieAPI.sharedInstance.getConfiguration { configuration, error in
            if error != nil {
                return
            }
            
            guard let configuration = configuration else {
                fatalError("Got passed error logic with no configuration.")
            }
            
            let imageURL = URL(string: "\(configuration.secureBaseURL!)\(configuration.actorImageDirectory!)\(actor.profileImageURL)")!
            
            if actor.profileImage != nil {
                self.headshotImageView.image = actor.profileImage
            } else {
                let session = URLSession.shared
                let request = URLRequest(url: imageURL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
                let task = session.downloadTask(with: request) { location, response, error in
                    if error != nil {
                        return
                    }
                    
                    let imageData = try! Data(contentsOf: location!)
                    
                    let image = UIImage(data: imageData)
                    actor.profileImageState = .downloaded
                    actor.profileImage = image
                    
                    DispatchQueue.main.async {
                        self.headshotImageView.image = image
                    }
                }
                
                task.resume()
            }
        }
    }
}
