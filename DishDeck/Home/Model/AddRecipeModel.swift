//
//  AddRecipeModel.swift
//  DishDeck
//
//  Created by Akash Shrestha on 2024-02-22.
//

import Foundation

struct RecipeIngredientsModel: Codable {
    var serialNum: Int?
    var name: String?
    var quantity: Int?
    var unit: String?
}

struct RecipeStepsModel: Codable {
    var step: String?
}
