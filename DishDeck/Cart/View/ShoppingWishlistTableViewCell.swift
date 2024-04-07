//
//  ShoppingWishlistTableViewCell.swift
//  DishDeck
//
//  Created by Akash Shrestha on 2024-03-26.
//

import UIKit
import IBAnimatable

class ShoppingWishlistTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgItem: AnimatableImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var viewIngredients: UIStackView!
    @IBOutlet weak var lblIngredients: UILabel!
    @IBOutlet weak var lblIngredientsRequired: UILabel!
    @IBOutlet weak var arrowIcon: UIImageView!
    
    static let identifier = "ShoppingWishlistTableViewCell"
    
    var deleteTapped: ((_ cell: ShoppingWishlistTableViewCell) -> Void)?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.layer.masksToBounds = true
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
//        lblIngredientsRequired.text = "ingredientsrequired".localized()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBAction func btnDeleteAction(_ sender: UIButton) {
        deleteTapped?(self)
    }
    
}
