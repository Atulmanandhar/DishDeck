//
//  AddStepsTableViewCell.swift
//  DishDeck
//
//  Created by Akash Shrestha on 2024-03-05.
//

import UIKit

class AddStepsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSteps: UILabel!
    @IBOutlet weak var tfSteps: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
