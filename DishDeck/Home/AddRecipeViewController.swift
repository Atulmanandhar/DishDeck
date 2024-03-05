//
//  AddRecipeViewController.swift
//  DishDeck
//
//  Created by Suzuse Rai on 2/13/24.
//

import UIKit

class AddRecipeViewController: UIViewController {
    
    @IBOutlet weak var lblIngredientCount: UILabel!
    @IBOutlet weak var txtIngredientName: UITextField!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var txtUnit: UITextField!
    
    @IBOutlet weak var lblStepCount: UILabel!
    @IBOutlet weak var txtStep: UITextField!
    
    var ingredientsList = [RecipeIngredientsModel]()
    var stepsList = [RecipeStepsModel]()
    var ingredientsObj = RecipeIngredientsModel()
    var stepsObj = RecipeStepsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnAddIngredientAction(_ sender: UIButton) {
        ingredientsObj.serialNum = (ingredientsList.count + 1)
        ingredientsObj.name = txtIngredientName.text
        ingredientsObj.quantity = Int(txtQuantity.text ?? "0")
        ingredientsList.append(ingredientsObj)
    }
    
    @IBAction func btnAddStepAction(_ sender: UIButton) {
        stepsObj.step = txtStep.text
        stepsList.append(stepsObj)
    }
    
    @IBAction func btnSubmitRecipeAction(_ sender: UIButton) {
        if ingredientsList.isEmpty {
            var obj = RecipeIngredientsModel()
            obj.serialNum = (ingredientsList.count + 1)
            obj.name = txtIngredientName.text
            obj.quantity = Int(txtQuantity.text ?? "0")
            ingredientsList.append(obj)
        }
        
        if stepsList.isEmpty {
            var obj = RecipeStepsModel()
            obj.step = txtStep.text
            stepsList.append(obj)
        }
        
        var obj = AddRecipeModel()
        obj.recipeIngredients = ingredientsList
        obj.recipeSteps = stepsList
        UserDefaultManager.shared.addRecipeModel = obj

        showAlert(title: "Recipe Added", msg: "Hooray!!! Your recipe has been added.") {
            self.navigationController?.popViewController(animated: true)
        }
    }

}
