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

extension String {
    func localized() -> String {
        if let appLanguage = DefaultManager.getAppLanguage() {
            if appLanguage == 2 {
                let path = Bundle.main.path(forResource: "fr", ofType: "lproj")
                let bundle = Bundle(path: path!)
                return NSLocalizedString(self, tableName: "Localizable", bundle: bundle!, value: self, comment: self)
            }
        }
        let path = Bundle.main.path(forResource: "en", ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: "Localizable", bundle: bundle!, value: self, comment: self)
    }
}


class DefaultManager: NSObject {
    static let KEY_AppLanguage = "appLanguage"
    
    static func setAppLanguage(ver: Int) {
        UserDefaults.standard.set(ver, forKey: KEY_AppLanguage)
        UserDefaults.standard.synchronize()
    }
    
    static func getAppLanguage() -> Int? {
        if let ver = UserDefaults.standard.value(forKey: KEY_AppLanguage) as? Int {
            return ver
        }
        return nil
    }
    
    static func removeAppLanguage() {
        UserDefaults.standard.removeObject(forKey: KEY_AppLanguage)
        UserDefaults.standard.synchronize()
    }
}
