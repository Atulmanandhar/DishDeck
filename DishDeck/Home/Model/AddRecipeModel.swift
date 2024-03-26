//
//  AddRecipeModel.swift
//  DishDeck
//
//  Created by Akash Shrestha on 2024-02-22.
//

import Foundation

struct RecipeModel: Codable {
    var recipeModel: [AddRecipeModel]?
}

struct AddRecipeModel: Codable {
    var recipeName: String?
    var recipeImage: Data?
    var recipeIngredients: [RecipeIngredientsModel]?
    var recipeSteps: [RecipeStepsModel]?
    var isInShoppingList: Bool = false
}

struct RecipeIngredientsModel: Codable {
    var serialNum: Int?
    var name: String?
    var quantity: Int?
    var unit: String?
}

struct RecipeStepsModel: Codable {
    var step: String?
}



