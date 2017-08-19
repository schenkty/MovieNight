//
//  MovieError.swift
//  MovieNight
//
//  Created by Ty Schenk on 8/5/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit

enum MovieError : Error {
    case jsonParsingError
    case unavailableData
}

extension MovieError {
    static func displayErrorWith(message: String, handler: @escaping ((UIAlertAction) -> Void)) -> UIAlertController {
        let alertController = UIAlertController(title: "An error has occured.", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: handler)
        alertController.addAction(okButton)
        return alertController
    }
}
