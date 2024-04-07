//
//  ProfileViewController.swift
//  DishDeck
//
//  Created by Akash Shrestha on 2024-02-12.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var lblMyProfile: UILabel!
    @IBOutlet weak var lblDarkMode: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var btnAddRecipe: UIButton!
    @IBOutlet weak var switchLang: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblMyProfile.text = "profile".localized()
        lblDarkMode.text = "darkmode".localized()
        lblLanguage.text = "language".localized()
        btnAddRecipe.setTitle("addrecipe".localized(), for: .normal)
        
        switchLang.isOn = DefaultManager.getAppLanguage() == 2 ? true : false
        
        updateUITabBarItemTitles()
    }
    
    func updateUITabBarItemTitles() {
        if let tabBarController = self.tabBarController {
            let titles = [
                "home",
                "cart",
                "profile"
            ]
            
            for (index, viewController) in tabBarController.viewControllers!.enumerated() {
                viewController.tabBarItem.title = titles[index].localized()
            }
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "back".localized(), style: .plain, target: nil, action: nil)
    }
    
    @IBAction func configLanguage(_ sender: UISwitch) {
        let newLanguage = (DefaultManager.getAppLanguage() != nil) == sender.isOn ? 2 : 1
        DefaultManager.setAppLanguage(ver: newLanguage)
        print(newLanguage)
        self.viewDidLoad()
    }

    @IBAction func btnAddRecipe(_ sender: UIButton) {
        let vc = UIStoryboard(name: "AddRecipe", bundle: nil).instantiateViewController(withIdentifier: "AddRecipeViewController") as! AddRecipeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
