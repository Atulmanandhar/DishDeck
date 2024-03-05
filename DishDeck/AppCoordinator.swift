//
//  AppCoordinator.swift
//  DishDeck
//
//  Created by Akash Shrestha on 2024-02-12.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    func start()
}

class AppCoordinator: Coordinator {
    
    let window: UIWindow!
    
    init(w: UIWindow!) {
        self.window = w
    }
    
    func start() {
        let resultViewController = getDashboardWithNavBar()
        window.rootViewController = resultViewController
        window.makeKeyAndVisible()
    }
    
    func getDashboardWithNavBar() -> UINavigationController {
        let tabBarController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "MyTabBarController")
                
        let navigationController = UINavigationController(rootViewController: tabBarController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "",
                                                                                        style: .plain, target: self, action: nil)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.setValue(true, forKey: "hidesShadow")
        
        
        navigationController.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 0.4)
        navigationController.navigationBar.layer.shadowRadius = 0.5
        navigationController.navigationBar.layer.shadowOpacity = 0.2
        navigationController.navigationBar.layer.masksToBounds = false
        
        return navigationController
    }
    
}
