//
//  AddRecipeViewController.swift
//  DishDeck
//
//  Created by Suzuse Rai on 2/13/24.
//

import UIKit

class AddRecipeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        navigationItem.rightBarButtonItems = [done]
    }
    
    @objc func doneTapped() {
        self.dismiss(animated: true)
    }

}
