//
//  UIViewController+Helpers.swift
//  NasaApp
//
//  Created by Anthony Tulai on 2018-08-28.
//  Copyright © 2018 Anthony Tulai. All rights reserved.
//

import UIKit

extension UIViewController {
    func showGenericErrorAlert(message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
