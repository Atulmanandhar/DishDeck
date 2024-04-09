//
//  RecipeDetailsViewController.swift
//  DishDeck
//
//  Created by Akash Shrestha on 2024-02-12.
//

import UIKit

class RecipeDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblRecipeName: UILabel!
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var stepsTableView: UITableView!
    
    @IBOutlet weak var ingredientsTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var stepsTableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lblIngredientsRequired: UILabel!
    @IBOutlet weak var lblCookingSteps: UILabel!
    @IBOutlet weak var btnWishlist: UIButton!
    
    var getIndexPath = 0
    var recipeDetails = AddRecipeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wishlistBtnConfig()
        recipeDetailsConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        langConfig()
    }
    
    private func langConfig() {
        lblIngredientsRequired.text = "ingredientsrequired".localized()
        lblCookingSteps.text = "cookingsteps".localized()
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
    
    private func recipeDetailsConfig() {
        if let recipeData = UserDefaultManager.shared.addRecipeModel[getIndexPath].recipeModel {
            recipeDetails = recipeData
            lblRecipeName.text = recipeDetails.recipeName
            
            if let imageData = recipeDetails.recipeImage {
                if let image = UIImage(data: imageData) {
                    imgFood.image = image
                    print("Image loaded successfully")
                } else {
                    print("Failed to load image")
                }
            } else {
                print("No image data found")
            }
            
            tableConfig()
        }
    }
    
    private func wishlistBtnConfig() {
        if  let model = UserDefaultManager.shared.addRecipeModel[getIndexPath].recipeModel?.isInShoppingList {
            btnWishlist.tag = model ? 0 : 1
            btnWishlist.setTitle(model ? "removefromwishlit".localized() : "addtoshoppinglist".localized(), for: .normal)
        }
        
    }
    
    @IBAction func btnAddWishListAction(_ sender: UIButton) {
        var model = UserDefaultManager.shared.addRecipeModel
        
        if btnWishlist.tag == 1 {
            model[getIndexPath].recipeModel?.isInShoppingList = true
        } else {
            model[getIndexPath].recipeModel?.isInShoppingList = false
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
        var count = 0
        if tableView == ingredientsTableView {
            count = recipeDetails.recipeIngredients?.count ?? 0
        } else {
            count = recipeDetails.recipeSteps?.count ?? 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var mainCell = UITableViewCell()
        
        if tableView == ingredientsTableView {
            let cell = ingredientsTableView.dequeueReusableCell(withIdentifier: "IngredientsTableViewCell", for: indexPath) as! IngredientsTableViewCell
            cell.ingredientLabel.text = recipeDetails.recipeIngredients?[indexPath.item].name
            mainCell = cell
        } else {
            let cell = stepsTableView.dequeueReusableCell(withIdentifier: "CookingStepsTableViewCell", for: indexPath) as! CookingStepsTableViewCell
            cell.recipeStepLabel.text = recipeDetails.recipeSteps?[indexPath.item].step
            mainCell = cell
        }
        
        return mainCell
    }
    
}

