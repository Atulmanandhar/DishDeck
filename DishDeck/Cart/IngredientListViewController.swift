//
//  IngredientListViewController.swift
//  DishDeck
//
//  Created by Akash Shrestha on 2024-03-27.
//

import UIKit

class IngredientListViewController: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblIngredientList: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    
    var wishlistData = [RecipeModel]()
    var listArray = [String]()
    var ingrdients = ""
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchListData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        langConfig()
    }
    
    private func langConfig() {
        lblIngredientList.text = "ingredientsrequired".localized()
        btnClose.setTitle("close".localized(), for: .normal)
    }
    
    private func fetchListData() {
        let recipeList = UserDefaultManager.shared.addRecipeModel
        for item in recipeList {
            if item.recipeModel?.isInShoppingList == true {
                wishlistData.append(item)
            }
        }
        listConfig()
    }
    
    private func listConfig() {
        for item in wishlistData {
            for listItem in item.recipeModel?.recipeIngredients ?? [] {
                listArray.append(listItem.name ?? "")
            }
        }
        
        let filteredArray = Array(Set(listArray.map{$0.lowercased() }))
        for item in filteredArray {
            count += 1
            ingrdients += "\(count). " + (item) + "\n"
        }
        lblName.text = ingrdients
    }

    @IBAction func btnClose(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
