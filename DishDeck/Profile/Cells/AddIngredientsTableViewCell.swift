//
//  AddIngredientsTableViewCell.swift
//  DishDeck
//
//  Created by Akash Shrestha on 2024-03-05.
//

import UIKit

class AddIngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientCountLabel: UILabel!
    @IBOutlet weak var tfIngredientName: UITextField!
    @IBOutlet weak var tfQuantity: UITextField!
    @IBOutlet weak var tfUnit: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
