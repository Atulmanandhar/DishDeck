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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
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
