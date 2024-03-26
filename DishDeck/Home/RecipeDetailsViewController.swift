//
//  RecipeDetailsViewController.swift
//  DishDeck
//
//  Created by Akash Shrestha on 2024-02-12.
//

import UIKit

class RecipeDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var stepsTableView: UITableView!
    
    @IBOutlet weak var ingredientsTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var stepsTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnWishlist: UIButton!
    
    var getIndexPath = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableConfig()
        wishlistBtnConfig()
    }
    
    private func tableConfig() {
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.isScrollEnabled = false
        
        stepsTableView.delegate = self
        stepsTableView.dataSource = self
        stepsTableView.isScrollEnabled = false
        
        ingredientsTableViewHeight.constant = .greatestFiniteMagnitude
        ingredientsTableView.layoutIfNeeded()
        ingredientsTableView.reloadData()
        ingredientsTableViewHeight.constant = ingredientsTableView.contentSize.height
        
        stepsTableViewHeight.constant = .greatestFiniteMagnitude
        stepsTableView.layoutIfNeeded()
        stepsTableView.reloadData()
        stepsTableViewHeight.constant = stepsTableView.contentSize.height
    }
    
    private func wishlistBtnConfig() {
        if  let model = UserDefaultManager.shared.addRecipeModel[getIndexPath].recipeModel?[0].isInShoppingList {
            btnWishlist.tag = model ? 0 : 1
            btnWishlist.setTitle(model ? "Remove from Wishlist" : "Add to Shopping Wishlist", for: .normal)
        }
        
    }
    
    @IBAction func btnAddWishListAction(_ sender: UIButton) {
        var model = UserDefaultManager.shared.addRecipeModel
        
        if let recipeModels = model[getIndexPath].recipeModel {
            if recipeModels.indices.contains(0) {
                if btnWishlist.tag == 1 {
                    model[getIndexPath].recipeModel?[0].isInShoppingList = true
                } else {
                    model[getIndexPath].recipeModel?[0].isInShoppingList = false
                }
            }
        }
        
        UserDefaultManager.shared.addRecipeModel = model
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03, execute: {
            if self.btnWishlist.tag == 1 {
                self.showAlert(title: "", msg: "Recipe added to shopping wishlist.") {
                    self.dismiss(animated: true)
                }
            } else {
                self.showAlert(title: "", msg: "Recipe removed from shopping wishlist.") {
                    self.dismiss(animated: true)
                }
            }
            self.wishlistBtnConfig()
        })
    }
    
}

extension RecipeDetailsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var mainCell = UITableViewCell()
        
        if tableView == ingredientsTableView {
            let cell = ingredientsTableView.dequeueReusableCell(withIdentifier: "IngredientsTableViewCell", for: indexPath) as! IngredientsTableViewCell
            cell.ingredientLabel.text = "\(indexPath.item + 1) Ingr"
            mainCell = cell
        }
        else {
            let cell = stepsTableView.dequeueReusableCell(withIdentifier: "CookingStepsTableViewCell", for: indexPath) as! CookingStepsTableViewCell
            cell.recipeStepLabel.text = "Step \(indexPath.item + 1) Stepps"
            mainCell = cell
        }
        
        
        return mainCell
    }
    
}
