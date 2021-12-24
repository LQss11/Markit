//
//  ViewEmployeeViewController.swift
//  Markit
//
//  Created by Affes Salem on 1/1/21.
//  Copyright © 2021 ESPRIT. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextFields

class ViewEmployeeViewController: UIViewController {
    @IBOutlet weak var empImage: UIImageView!
    @IBOutlet weak var lastname: MDCFilledTextField!

    @IBOutlet weak var username: MDCFilledTextField!
    @IBOutlet weak var phone: MDCFilledTextField!
    @IBOutlet weak var address: MDCFilledTextField!
    @IBOutlet weak var mail: MDCFilledTextField!
    @IBOutlet weak var firstname: MDCFilledTextField!
    @IBOutlet weak var modifyEmp: UIButton!
    @IBOutlet weak var deleteEmp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userDef = UserDefaults.standard
        if let savedPerson = userDef.object(forKey: "emp") as? Data {
            let decoder = JSONDecoder()
            let loadedPerson = try? decoder.decode(UserModel.self, from: savedPerson)
            firstname.text = loadedPerson!.firstname
            lastname.text = loadedPerson!.lastname
            username.text = loadedPerson!.username
            address.text = loadedPerson!.address
            phone.text = loadedPerson!.phone
            mail.text = loadedPerson!.mail


            
            let url = URL(string: Statics.IMGURL+loadedPerson!.image!+".jpg")!

            // Fetch Image Data
            if let data = try? Data(contentsOf: url) {
                // Create Image and Update Image View
                empImage.image = UIImage(data: data)
                empImage.contentMode = .scaleAspectFit

            }

        }

    }
    
    @IBAction func deleteEmployee(_ sender: UIButton) {
        
        let userDef = UserDefaults.standard
        if let savedPerson = userDef.object(forKey: "emp") as? Data {
            let decoder = JSONDecoder()
            let loadedPerson = try? decoder.decode(UserModel.self, from: savedPerson)
            UserController.delUser(id: loadedPerson!.id ?? "0")
            
            let alert = UIAlertController(title: "Delete!", message: "Employee deleted successfuly!" , preferredStyle: UIAlertController.Style.alert)
                                               alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                               self.present(alert, animated: true, completion: nil)

            
            
        }
        
    }
    @IBAction func modifyEmployee(_ sender: UIButton) {
        
        let userDef = UserDefaults.standard
        if let savedPerson = userDef.object(forKey: "emp") as? Data {
            let decoder = JSONDecoder()
            let loadedPerson = try? decoder.decode(UserModel.self, from: savedPerson)
            let u = UserModel.init(firstname: firstname.text, lastname: lastname.text, username: username.text, mail: mail.text, phone: phone.text, address: address.text)

            UserController.Put2(id: loadedPerson!.id ?? "0", u: u)
            
            let alert = UIAlertController(title: "Update", message: "Employee updated successfuly!" , preferredStyle: UIAlertController.Style.alert)
                                               alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                               self.present(alert, animated: true, completion: nil)

            
        }
        
    }
    
}
