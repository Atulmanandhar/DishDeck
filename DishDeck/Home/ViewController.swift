//
//  ViewController.swift
//  DishDeck
//
//  Created by Atul Manandhar on 22/01/2024.
//
 
import UIKit
 
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lblYourRecipe: UILabel!
    @IBOutlet weak var recipeTableView: UITableView!
 
    var recipeList = [RecipeModel]()
    var filteredList = [RecipeModel]()
 
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
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.text = ""
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
        filteredList = recipeList
        recipeTableView.reloadData()
    }
 
    @IBAction func btnRecipeDetails(_ sender: UIButton) {
        let vc = UIStoryboard(name: "RecipeDetails", bundle: nil).instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
 
}
 
extension ViewController {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipeTableView.dequeueReusableCell(withIdentifier: "RecipesTableViewCell", for: indexPath) as! RecipesTableViewCell
        let model = filteredList[indexPath.item].recipeModel?.recipeName
        cell.recipeName.text = model
 
        if let imageData = filteredList[indexPath.item].recipeModel?.recipeImage {
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
        vc.getIndexPath = filteredList[indexPath.item].recipeModel?.id ?? 0
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
 
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredList = []
        if searchText == "" {
            filteredList = recipeList
        }
 
        for item in recipeList {
            if let recipeName =  item.recipeModel?.recipeName?.uppercased(), recipeName.contains(searchText.uppercased()) {
                filteredList.append(item)
            }
        }
        recipeTableView.reloadData()
    }
}
