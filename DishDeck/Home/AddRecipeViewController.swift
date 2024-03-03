//
//  AddRecipeViewController.swift
//  DishDeck
//
//  Created by Suzuse Rai on 2/13/24.
//

import UIKit

class AddRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var lblIngredientCount: UILabel!
    @IBOutlet weak var txtIngredientName: UITextField!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var txtUnit: UITextField!
    
    @IBOutlet weak var lblStepCount: UILabel!
    @IBOutlet weak var txtStep: UITextField!
    
    @IBOutlet weak var imgRecipe: UIImageView!
    
    var ingredientsList = [RecipeIngredientsModel]()
    var stepsList = [RecipeStepsModel]()
    var ingredientsObj = RecipeIngredientsModel()
    var stepsObj = RecipeStepsModel()
    var imageUrl: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialDataConfig()
//        UserDefaults.standard.removeObject(forKey: "ADD_RECIPE_MODEL")
    }
    
    func initialDataConfig() {
        let recipeModel = UserDefaultManager.shared.addRecipeModel
        
        if recipeModel.recipeIngredients?.count != nil || recipeModel.recipeSteps?.count != nil {
            lblIngredientCount.text = "Ingredients: \(recipeModel.recipeIngredients?.count ?? 0)"
            txtIngredientName.text = recipeModel.recipeIngredients?[0].name
            txtQuantity.text = "\(recipeModel.recipeIngredients?[0].quantity ?? 0)"
            txtUnit.text = recipeModel.recipeIngredients?[0].unit
            
            lblStepCount.text = "Steps: \(recipeModel.recipeSteps?.count ?? 0)"
            txtStep.text = recipeModel.recipeSteps?[0].step
            print("Show the data")
            
//            guard let fileURL = recipeModel.recipeImage else { return } // The file URL where the image was saved
//            print(fileURL)
//            if let imageData = try? Data(contentsOf: fileURL) {
//                let image = UIImage(data: imageData)
//                imgRecipe.image = image
//            }
            
//            if let imageUrl = recipeModel.recipeImage {
//                    print("Image URL: \(imageUrl)")
//                    // Load the image from the file URL
//                    if let imageData = try? Data(contentsOf: imageUrl) {
//                        print("Image data size: \(imageData.count)")
//                        let image = UIImage(data: imageData)
//                        imgRecipe.image = image
//                    } else {
//                        print("Failed to load image data from URL")
//                    }
//                } else {
//                    print("Image URL is nil")
//                }
            
            
            
            if let imageData = recipeModel.recipeImage {
                    if let image = UIImage(data: imageData) {
                        imgRecipe.image = image
                        print("Image loaded successfully")
                    } else {
                        print("Failed to load image")
                    }
                } else {
                    print("No image data found")
                }
        } else {
            print("No data to be shown")
        }
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
            // Do something with the image
            // Save the image to the device's documents directory
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
            
            // Display it in an UIImageView
            imgRecipe.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }

    @IBAction func btnSelectImage(_ sender: UIButton) {
        openImagePicker()
    }
    
    
    @IBAction func btnAddIngredientAction(_ sender: UIButton) {
        ingredientsObj.serialNum = (ingredientsList.count + 1)
        ingredientsObj.name = txtIngredientName.text
        ingredientsObj.quantity = Int(txtQuantity.text ?? "0")
        ingredientsList.append(ingredientsObj)
    }
    
    @IBAction func btnAddStepAction(_ sender: UIButton) {
        stepsObj.step = txtStep.text
        stepsList.append(stepsObj)
    }
    
    @IBAction func btnSubmitRecipeAction(_ sender: UIButton) {
        if ingredientsList.isEmpty {
            var obj = RecipeIngredientsModel()
            obj.serialNum = (ingredientsList.count + 1)
            obj.name = txtIngredientName.text
            obj.quantity = Int(txtQuantity.text ?? "0")
            obj.unit = txtUnit.text
            ingredientsList.append(obj)
        }
        
        if stepsList.isEmpty {
            var obj = RecipeStepsModel()
            obj.step = txtStep.text
            stepsList.append(obj)
        }
        
//        UserDefaultManager.shared.saveRecipeIngredients = ingredientsList
//        UserDefaultManager.shared.saveRecipeSteps = stepsList
//        print(ingredientsList)
//        print(stepsList)
        
        var obj = AddRecipeModel()
        obj.recipeImage = imageUrl
        obj.recipeIngredients = ingredientsList
        obj.recipeSteps = stepsList
        UserDefaultManager.shared.addRecipeModel = obj
        
        print(obj)
    }

}
