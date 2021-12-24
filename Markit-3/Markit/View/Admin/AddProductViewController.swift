//
//  AddProductViewController.swift
//  Markit
//
//  Created by Esprit on 12/9/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit

import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class AddProductViewController: UIViewController {

    var image_data : NSURL?

    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var name: MDCFilledTextField!
    @IBOutlet weak var price: MDCFilledTextField!
    @IBOutlet weak var total: MDCFilledTextField!
    @IBOutlet weak var dateadded: MDCFilledTextField!
    @IBOutlet weak var barcode: MDCFilledTextField!
    @IBOutlet weak var desc: MDCFilledTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        btn(label: "name", placeholder: "name", btn: name)
        btn(label: "price", placeholder: "price", btn: price)
        btn(label: "total", placeholder: "total", btn: total)
        btn(label: "dateadded", placeholder: "dateadded", btn: dateadded)
        btn(label: "barcode", placeholder: "barcode", btn: barcode)
        btn(label: "desc", placeholder: "desc", btn: desc)
        */
        
        
    }
    
    
    

    func btn(label: String, placeholder: String,btn:MDCFilledTextField!)
    {
        btn.label.text = label
        btn.placeholder = placeholder
        btn.center = self.view.center
        btn.sizeToFit()
    }
    @IBAction func submitAdd(_ sender: UIButton) {
        let userDef = UserDefaults.standard
        if let savedPerson = userDef.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            let loadedPerson = try? decoder.decode(UserModel.self, from: savedPerson)
        let u = ProductModel(name: name.text, price: price.text, total: total.text, dateadded: dateadded.text, barcode: barcode.text, desc: desc.text, category: nil, company:loadedPerson!.company!)

            ProductController.Post(u:u, im: (self.image_data?.filePathURL)!)
            
            let alert = UIAlertController(title: "Notice", message: "Product added successfuly!" , preferredStyle: UIAlertController.Style.alert)
                                               alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                               self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func didTapButton(_ sender: Any) {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType =  UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
           
        
    }
}


extension   AddProductViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        
        self.image_data = info[.imageURL] as! NSURL?
        self.imageview.image = info[.originalImage] as! UIImage?
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
