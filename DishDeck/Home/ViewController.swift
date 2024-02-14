//
//  ViewController.swift
//  DishDeck
//
//  Created by Atul Manandhar on 22/01/2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var recipeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    @IBAction func btnRecipeDetails(_ sender: UIButton) {
        let vc = UIStoryboard(name: "RecipeDetails", bundle: nil).instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipesTableViewCell", for: indexPath) as! RecipesTableViewCell
        cell.recipeName.text = "Recipe \(indexPath.item + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "RecipeDetails", bundle: nil).instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
