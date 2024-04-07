//
//  CartViewController.swift
//  DishDeck
//
//  Created by Akash Shrestha on 2024-02-12.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var lblShoppingList: UILabel!
    @IBOutlet weak var btnAllIngredinets: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    var cellHeights = [IndexPath: CGFloat]()
    var wishlistData = [RecipeModel]()
    var expansionData = [Expansion]()


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchWishList()
        langConfig()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        wishlistData.removeAll()
        expansionData.removeAll()
    }
    
    private func langConfig() {
        lblShoppingList.text = "shoppingwishlist".localized()
        btnAllIngredinets.setTitle("viewallingredients".localized(), for: .normal)
    }
    
    private func tableConfig() {
        tblView.separatorStyle = .none
        tblView.tableFooterView = UIView()
        
        tblView.estimatedRowHeight = UITableView.automaticDimension
        tblView.rowHeight = UITableView.automaticDimension
        
        tblView.register(ShoppingWishlistTableViewCell.nib(), forCellReuseIdentifier: ShoppingWishlistTableViewCell.identifier)
        tblView.reloadData()
    }
    
    private func fetchWishList() {
        let recipeList = UserDefaultManager.shared.addRecipeModel
        for item in recipeList {
            if item.recipeModel?.isInShoppingList == true {
                wishlistData.append(item)
                expansionData.append(Expansion(isExpanded: false))
            }
        }
        tableConfig()
    }
    
    private func removeFromWishList(indexPath: Int) {
        var model = UserDefaultManager.shared.addRecipeModel
        model[indexPath].recipeModel?.isInShoppingList = false
        
        UserDefaultManager.shared.addRecipeModel = model
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03, execute: {
            self.showAlert(title: "", msg: "Recipe removed from shopping wishlist.") {
                self.dismiss(animated: true)
            }
            self.wishlistData.removeAll()
            self.expansionData.removeAll()
            self.fetchWishList()
        })
    }

    @IBAction func btnViewAllList(_ sender: UIButton) {
        let vc = UIStoryboard(name: "IngredientList", bundle: nil).instantiateViewController(withIdentifier: "IngredientListViewController") as! IngredientListViewController
        self.present(vc, animated: true)
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishlistData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: ShoppingWishlistTableViewCell.identifier, for: indexPath) as! ShoppingWishlistTableViewCell
        let cellExpansion = expansionData[indexPath.item]
        if let model = wishlistData[indexPath.item].recipeModel {
            if cellExpansion.isExpanded {
                cell.arrowIcon.transform = CGAffineTransform(rotationAngle: .pi)
            } else {
                cell.arrowIcon.transform = CGAffineTransform.identity
            }
            
            if let imageData = wishlistData[indexPath.item].recipeModel?.recipeImage {
                if let image = UIImage(data: imageData) {
                    cell.imgItem.image = image
                    print("Image loaded successfully")
                } else {
                    print("Failed to load image")
                }
            } else {
                print("No image data found")
            }
            
            cell.lblItemName.text = model.recipeName
            
            var ingredients = ""
            for item in model.recipeIngredients ?? [] {
                ingredients += (item.name ?? "") + "\n"
            }
            cell.lblIngredients.text = ingredients
            cell.viewIngredients.isHidden = !cellExpansion.isExpanded
            
            cell.lblIngredientsRequired.text = "ingredientsrequired".localized()
        }

        cell.deleteTapped = { [weak self] view in
            print("\(indexPath.item) clicked...")
            self?.removeFromWishList(indexPath: indexPath.item)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        expansionData[indexPath.item].isExpanded = !expansionData[indexPath.item].isExpanded
        tblView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? UITableView.automaticDimension
    }
}

struct Expansion {
    var isExpanded: Bool = false
}
