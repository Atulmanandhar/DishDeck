//
//  ViewController.swift
//  DishDeck
//
//  Created by Atul Manandhar on 22/01/2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var lblYourRecipe: UILabel!
    @IBOutlet weak var recipeTableView: UITableView!
    
    var recipeList = [RecipeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecipeData()
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getRecipeData()
        updateUITabBarItemTitles()
        lblYourRecipe.text = "yourdeliciousrecipe".localized()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "back".localized(), style: .plain, target: nil, action: nil)
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
    }
    
    func getRecipeData() {
        recipeList = UserDefaultManager.shared.addRecipeModel
        recipeTableView.reloadData()
    }

    @IBAction func btnRecipeDetails(_ sender: UIButton) {
        let vc = UIStoryboard(name: "RecipeDetails", bundle: nil).instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipesTableViewCell", for: indexPath) as! RecipesTableViewCell
        let model = recipeList[indexPath.item].recipeModel?.recipeName
        cell.recipeName.text = model

        if let imageData = recipeList[indexPath.item].recipeModel?.recipeImage {
            if let image = UIImage(data: imageData) {
                cell.recipeImage.image = image
                print("Image loaded successfully")
            } else {
                print("Failed to load image")
            }
        } else {
            print("No image data found")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "RecipeDetails", bundle: nil).instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController
        vc.getIndexPath = indexPath.item
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Alert!", message: "Are you sure, you want to delete this awesome recipe?", preferredStyle: .alert)
            let okAlert = UIAlertAction(title: "Okay", style: .destructive) { action in
                var list = UserDefaultManager.shared.addRecipeModel
                list.remove(at: indexPath.item)
                UserDefaultManager.shared.addRecipeModel = list
                self.getRecipeData()
            }
            let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(okAlert)
            alert.addAction(cancelAlert)
            self.present(alert, animated: true)
        }
    }
}
