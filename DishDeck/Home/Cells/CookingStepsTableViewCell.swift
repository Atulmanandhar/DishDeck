//
//  CookingStepsTableViewCell.swift
//  DishDeck
//
//  Created by Atul Manandhar on 12/02/2024.
//

import UIKit

class CookingStepsTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeStepLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
