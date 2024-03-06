//
//  Util.swift
//  DishDeck
//
//  Created by Akash Shrestha on 2024-03-04.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, msg: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default) { action in
            completion()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
