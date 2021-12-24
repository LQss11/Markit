//
//  userProfilViewController.swift
//  Markit
//
//  Created by Esprit on 1/8/21.
//  Copyright © 2021 ESPRIT. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextFields
class userProfilViewController: UIViewController {

    @IBOutlet weak var address: MDCFilledTextField!
    @IBOutlet weak var phone: MDCFilledTextField!
    @IBOutlet weak var mail: MDCFilledTextField!
    @IBOutlet weak var username: MDCFilledTextField!
    @IBOutlet weak var firstnamel: MDCFilledTextField!
    @IBOutlet weak var lastname: MDCFilledTextField!
    //
    //  ProfileViewController.swift
    //  Markit
    //
    //  Created by Affes Salem on 1/1/21.
    //  Copyright © 2021 ESPRIT. All rights reserved.
    //

   

        @IBOutlet weak var modifyButton: UIButton!
       
        override func viewDidLoad() {
            super.viewDidLoad()
            let userDef = UserDefaults.standard
            if let savedPerson = userDef.object(forKey: "user") as? Data {
                let decoder = JSONDecoder()
                let loadedPerson = try? decoder.decode(UserModel.self, from: savedPerson)
                firstnamel.text = loadedPerson!.firstname
                lastname.text = loadedPerson!.lastname
                username.text = loadedPerson!.username
                mail.text = loadedPerson!.mail
                phone.text = loadedPerson!.phone
                address.text = loadedPerson!.address

                
            }
        }
        
        @IBAction func modifyUser(_ sender: UIButton) {
            
            let userDef = UserDefaults.standard
            if let savedPerson = userDef.object(forKey: "user") as? Data {
                let decoder = JSONDecoder()
                let loadedPerson = try? decoder.decode(UserModel.self, from: savedPerson)
                let u = UserModel.init(firstname: firstnamel.text, lastname: lastname.text, username: username.text, mail: mail.text, phone: phone.text, address: address.text)

                UserController.Put2(id: loadedPerson!.id ?? "0", u: u)


                
            }
            
        }
        

    }
