//
//  ProfileViewController.swift
//  DishDeck
//
//  Created by Akash Shrestha on 2024-02-12.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    


    @IBAction func btnAddRecipe(_ sender: UIButton) {
        let vc = UIStoryboard(name: "AddRecipe", bundle: nil).instantiateViewController(withIdentifier: "AddRecipeViewController") as! AddRecipeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
