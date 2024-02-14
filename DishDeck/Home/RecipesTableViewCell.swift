//
//  RecipesTableViewCell.swift
//  DishDeck
//
//  Created by Subash Chalise on 2024-02-12.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeDetail: UILabel!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
