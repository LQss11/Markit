//
//  ProfileViewController.swift
//  Markit
//
//  Created by Affes Salem on 1/1/21.
//  Copyright © 2021 ESPRIT. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextFields
class ProfileViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var address: MDCFilledTextField!
    @IBOutlet weak var phone: MDCFilledTextField!
    @IBOutlet weak var mail: MDCFilledTextField!
    @IBOutlet weak var username: MDCFilledTextField!
    @IBOutlet weak var firstname: MDCFilledTextField!
    @IBOutlet weak var modifyButton: UIButton!
    @IBOutlet weak var lastname: MDCFilledTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDef = UserDefaults.standard
        if let savedPerson = userDef.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            let loadedPerson = try? decoder.decode(UserModel.self, from: savedPerson)
            firstname.text = loadedPerson!.firstname
            lastname.text = loadedPerson!.lastname
            username.text = loadedPerson!.username
            mail.text = loadedPerson!.mail
            phone.text = loadedPerson!.phone
            address.text = loadedPerson!.address

            let url = URL(string: Statics.IMGURL+loadedPerson!.image!+".jpg")!

            // Fetch Image Data
            if let data = try? Data(contentsOf: url) {
                // Create Image and Update Image View
                imageView.image = UIImage(data: data)
                imageView.contentMode = .scaleAspectFit

            }
        }
    }
    
    @IBAction func modifyUser(_ sender: UIButton) {
        
        let userDef = UserDefaults.standard
        if let savedPerson = userDef.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            let loadedPerson = try? decoder.decode(UserModel.self, from: savedPerson)
            let u = UserModel.init(firstname: firstname.text, lastname: lastname.text, username: username.text, mail: mail.text, phone: phone.text, address: address.text)

            UserController.Put2(id: loadedPerson!.id ?? "0", u: u)

            let alert = UIAlertController(title: "Update", message: "User updated successfuly!" , preferredStyle: UIAlertController.Style.alert)
                                               alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                               self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    

}
