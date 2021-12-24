//
//  ViewProductViewController.swift
//  Markit
//
//  Created by Affes Salem on 1/1/21.
//  Copyright © 2021 ESPRIT. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextFields
class ViewProductViewController: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: MDCFilledTextField!
    @IBOutlet weak var productPrice: MDCFilledTextField!
    
    @IBOutlet weak var productTotal: MDCFilledTextField!
    @IBOutlet weak var productBarcode: MDCFilledTextField!


    @IBOutlet weak var productDescription: MDCFilledTextField!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var modifyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDef = UserDefaults.standard
        if let savedPerson = userDef.object(forKey: "product") as? Data {
            let decoder = JSONDecoder()
            let loadedPerson = try? decoder.decode(ProductModel.self, from: savedPerson)
            productName.text = loadedPerson!.name
            productPrice.text = loadedPerson!.price
            productTotal.text = loadedPerson!.total
            productBarcode.text = loadedPerson!.barcode
            productDescription.text = loadedPerson!.desc


            
            let url = URL(string: Statics.IMGURL+loadedPerson!.image!+".jpg")!

            // Fetch Image Data
            if let data = try? Data(contentsOf: url) {
                // Create Image and Update Image View
                productImage.image = UIImage(data: data)
                productImage.contentMode = .scaleAspectFit

            }

        }
        
    }
    @IBAction func deleteProduct(_ sender: UIButton) {
        let userDef = UserDefaults.standard
        if let savedPerson = userDef.object(forKey: "product") as? Data {
            let decoder = JSONDecoder()
            let loadedPerson = try? decoder.decode(ProductModel.self, from: savedPerson)
            ProductController.delProduct(id: loadedPerson!.id ?? 0)
            
            let alert = UIAlertController(title: "Delete", message: "Product deleted successfuly!" , preferredStyle: UIAlertController.Style.alert)
                                               alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                               self.present(alert, animated: true, completion: nil)
            
        }

    }
    
    @IBAction func modifyProduct(_ sender: UIButton) {
        let userDef = UserDefaults.standard
        if let savedPerson = userDef.object(forKey: "product") as? Data {
            let decoder = JSONDecoder()
            let loadedPerson = try? decoder.decode(ProductModel.self, from: savedPerson)
            let u = ProductModel.init(name: productName.text, price: productPrice.text, total: productTotal.text, barcode: productBarcode.text, desc: productDescription.text, image: loadedPerson!.image)
            ProductController.Put(id: loadedPerson!.id ?? 0, u: u)
            
            let alert = UIAlertController(title: "Update", message: "Product updated successfuly!" , preferredStyle: UIAlertController.Style.alert)
                                               alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                               self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
}
