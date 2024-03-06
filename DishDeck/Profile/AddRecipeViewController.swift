//
//  AddRecipeViewController.swift
//  DishDeck
//
//  Created by Suzuse Rai on 2/13/24.
//

import UIKit

class AddRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var txtFoodName: UITextField!
    @IBOutlet weak var imgRecipe: UIImageView!
    @IBOutlet weak var tblViewIngredients: UITableView!
    @IBOutlet weak var tblViewIngredientsHeight: NSLayoutConstraint!
    
    @IBOutlet weak var tblViewSteps: UITableView!
    @IBOutlet weak var tblViewStepsHeight: NSLayoutConstraint!
    
    var ingredientsList = [RecipeIngredientsModel]()
    var stepsList = [RecipeStepsModel]()
    var ingredientsObj = RecipeIngredientsModel()
    var stepsObj = RecipeStepsModel()
    var imageUrl: Data?
    
    var items = [Item]()
    var stepItems = [StepItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableConfig()
    }
    
    func tableConfig() {
        tblViewIngredients.delegate = self
        tblViewIngredients.dataSource = self
        
        items.append(Item(tfName: "", tfQuantity: "", tfUnit: ""))
        tblViewIngredientsHeight.constant = CGFloat.greatestFiniteMagnitude
        tblViewIngredients.reloadData()
        tblViewIngredients.layoutIfNeeded()
        tblViewIngredientsHeight.constant = tblViewIngredients.contentSize.height
        tblViewIngredients.isScrollEnabled = false
        
        tblViewSteps.delegate = self
        tblViewSteps.dataSource = self
        
        stepItems.append(StepItem(tfStep: ""))
        tblViewStepsHeight.constant = CGFloat.greatestFiniteMagnitude
        tblViewSteps.reloadData()
        tblViewSteps.layoutIfNeeded()
        tblViewStepsHeight.constant = tblViewSteps.contentSize.height
        tblViewSteps.isScrollEnabled = false
    }
    
    func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self

        let alertController = UIAlertController(title: nil, message: "Choose Image Source", preferredStyle: .actionSheet)

        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }

        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
             if let data = pickedImage.jpegData(compressionQuality: 1.0) {
                 let fileName = "\(UUID().uuidString).jpg" // Generate unique filename
                 let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                 let fileURL = documentsDirectory.appendingPathComponent(fileName)
                 imageUrl = data
                 do {
                     try data.write(to: fileURL)
                     print("Image saved successfully at \(fileURL)")
                 } catch {
                     print("Error saving image: \(error)")
                 }
             }

             imgRecipe.image = pickedImage
         }
         dismiss(animated: true, completion: nil)
     }
    
    @IBAction func btnSelectImage(_ sender: UIButton) {
         openImagePicker()
     }
    
    @IBAction func btnAddIngredientAction(_ sender: UIButton) {
        items.append(Item(tfName: "", tfQuantity: "", tfUnit: ""))
        tblViewIngredients.reloadData()
        tblViewIngredientsHeight.constant = tblViewIngredients.contentSize.height
        view.layoutIfNeeded()
    }
    
    @IBAction func btnAddStepAction(_ sender: UIButton) {
        stepItems.append(StepItem(tfStep: ""))
        tblViewSteps.reloadData()
        tblViewStepsHeight.constant = tblViewSteps.contentSize.height
        view.layoutIfNeeded()
    }
    
    @IBAction func btnSubmitRecipeAction(_ sender: UIButton) {
        var allFieldsFilled = true
        
        for cell in tblViewIngredients.visibleCells {
            if let cell = cell as? AddIngredientsTableViewCell {
                if let indexPath = tblViewIngredients.indexPath(for: cell) {
                    if cell.tfIngredientName.text?.isEmpty ?? true || cell.tfQuantity.text?.isEmpty ?? true || cell.tfUnit.text?.isEmpty ?? true {
                        allFieldsFilled = false
                        break
                    }
                    
                    var obj = RecipeIngredientsModel()
                    obj.serialNum = (indexPath.item + 1)
                    obj.name = cell.tfIngredientName.text ?? ""
                    obj.quantity = Int(cell.tfQuantity.text ?? "0")
                    obj.unit = cell.tfUnit.text ?? ""
                    ingredientsList.append(obj)
                }
            }
        }
        
        for cell in tblViewSteps.visibleCells {
            if let cell = cell as? AddStepsTableViewCell {
                if let indexPath = tblViewSteps.indexPath(for: cell) {
                    if cell.tfSteps.text?.isEmpty ?? true {
                        // If any field is empty, set the flag to false and break the loop
                        allFieldsFilled = false
                        break
                    }
                    
                    var obj = RecipeStepsModel()
                    obj.step = cell.tfSteps.text ?? ""
                    stepsList.append(obj)
                }
            }
        }
        
        if txtFoodName.text?.isEmpty == true {
            allFieldsFilled = false
        }
        
        if !allFieldsFilled {
            showAlert(title: "Alert!", msg: "All textfields must be filled") {
                self.dismiss(animated: true)
            }
            return
        } else {
            var obj = AddRecipeModel()
            obj.recipeName = txtFoodName.text
            obj.recipeImage = imageUrl
            obj.recipeIngredients = ingredientsList
            obj.recipeSteps = stepsList
            
            var recipeData = RecipeModel()
            recipeData.recipeModel = [obj]
            
            UserDefaultManager.shared.addRecipeModel.append(recipeData)
            
            showAlert(title: "Recipe Added", msg: "Hooray!!! Your recipe has been added.") {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }

}

extension AddRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cellCount = 0
        if tableView == tblViewIngredients {
            cellCount = items.count
        }  else {
            cellCount = stepItems.count
        }
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var mainCell = UITableViewCell()
        if tableView == tblViewIngredients {
            let cell = tblViewIngredients.dequeueReusableCell(withIdentifier: "AddIngredientsTableViewCell", for: indexPath) as! AddIngredientsTableViewCell
            cell.ingredientCountLabel.text = "Ingredient \(indexPath.item + 1)"
            mainCell = cell
        }  else {
            let cell = tblViewSteps.dequeueReusableCell(withIdentifier: "AddStepsTableViewCell", for: indexPath) as! AddStepsTableViewCell
            cell.lblSteps.text = "Step \(indexPath.item + 1)"
            mainCell = cell
        }
        return mainCell
    }
    
}
