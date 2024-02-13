//
//  ViewController.swift
//  DishDeck
//
//  Created by Atul Manandhar on 22/01/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnRecipeDetails(_ sender: UIButton) {
        let vc = UIStoryboard(name: "RecipeDetails", bundle: nil).instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

