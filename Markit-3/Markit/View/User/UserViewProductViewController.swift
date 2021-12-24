//
//  ViewProductViewController.swift
//  Markit
//
//  Created by Affes Salem on 1/1/21.
//  Copyright © 2021 ESPRIT. All rights reserved.
//

import UIKit
import CoreData
import MaterialComponents.MaterialTextControls_FilledTextFields
class UserViewProductViewController: UIViewController {

      //var
      var name:String?
    var price:String?
    var image:String?
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescription: MDCFilledTextField!
    @IBOutlet weak var productBarcode: MDCFilledTextField!
    @IBOutlet weak var productDate: MDCFilledTextField!
    @IBOutlet weak var productTotal: MDCFilledTextField!
    @IBOutlet weak var productPrice: MDCFilledTextField!
    @IBOutlet weak var productName: MDCFilledTextField!
    
    @IBOutlet weak var addToChariot: UIButton!
    
     var favorites : [NSManagedObject] = []
    var prices : [NSManagedObject] = []


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
        }

    }
    
    @IBAction func addToChariot(_ sender: UIButton) {
        let userDef = UserDefaults.standard
        if let savedPerson = userDef.object(forKey: "product") as? Data {
            let decoder = JSONDecoder()
            let loadedPerson = try? decoder.decode(ProductModel.self, from: savedPerson)
            let u = ProductModel.init(name: loadedPerson!.name, price: loadedPerson!.price, total: loadedPerson!.total, barcode: loadedPerson!.barcode, desc: loadedPerson!.desc, image: loadedPerson!.image)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let PersistentContainer = appDelegate.persistentContainer
            let managedContext = PersistentContainer.viewContext
            
            name = loadedPerson!.name
            price = loadedPerson!.price
            image = loadedPerson!.image
            
            
                save()
                
                let alert = UIAlertController(title: "MarkIT", message: "Product saved successfully. ", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true)
            
            
    }
    }
    
    func save() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        let managedContext = persistentContainer.viewContext
        print("eeeee")
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Product", in: managedContext)
        let object = NSManagedObject.init(entity: entityDescription!, insertInto: managedContext)
        
        object.setValue(name!, forKey: "name")
         object.setValue(price!, forKey: "price")
        object.setValue(image!, forKey: "image")
        
        do {
            
            try managedContext.save()
            print("Product saved successfully !")
            
        } catch {
            
            print("Product insert error !")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "mSegue" {
            let param = sender as! String
            let destination = segue.destination as! chariotViewController
            destination.name = param
            destination.price = param
            destination.image = param
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = favorites[indexPath.row]
        let movie1 = prices[indexPath.row]
        
        performSegue(withIdentifier: "mSegue", sender: movie)
        performSegue(withIdentifier: "mSegue", sender: movie1)
        
    }
    
     
    
}
