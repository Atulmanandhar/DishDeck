//
//  UserDefaultManager.swift
//  DishDeck
//
//  Created by Akash Shrestha on 2024-02-22.
//

import Foundation

class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    
    let userDefault = UserDefaults.standard
    
    // UserDefault Constants
    private let ADD_RECIPE_MODEL = "ADD_RECIPE_MODEL"
    private let RECIPE_INGREDIENTS_MODEL = "RECIPE_INGREDIENTS_MODEL"
    private let RECIPE_STEPS_MODEL = "RECIPE_STEPS_MODEL"
    
    var addRecipeModel: AddRecipeModel {
        get {
            if let model: AddRecipeModel = getModel(key: ADD_RECIPE_MODEL) {
                return model
            }
            return AddRecipeModel()
        } set {
            saveModel(model: newValue, key: ADD_RECIPE_MODEL)
        }
    }
    
    var saveRecipeIngredients : [RecipeIngredientsModel] {
        get {
            if let model: [RecipeIngredientsModel] = getModel(key: RECIPE_INGREDIENTS_MODEL) {
                return model
            }
            return []
        }set {
            saveModel(model: newValue, key: RECIPE_INGREDIENTS_MODEL)
        }
    }
    
    var saveRecipeSteps : [RecipeStepsModel] {
        get {
            if let model: [RecipeStepsModel] = getModel(key: RECIPE_STEPS_MODEL) {
                return model
            }
            return []
        }set {
            saveModel(model: newValue, key: RECIPE_STEPS_MODEL)
        }
    }
    
    // MARK:- Saving and retrieving recipe model
    private func saveModel<T: Codable> (model : T, key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(model) {
            userDefault.set(encoded, forKey: key)
        }
    }

    private func getModel<T: Codable> (key: String) -> T? {
        if let model = userDefault.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let model = try? decoder.decode(T.self, from: model) {
                return model
            }
        }
        return nil
    }
    
}
