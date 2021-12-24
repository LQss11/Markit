//
//  UserHomePageViewController.swift
//  Markit
//
//  Created by Esprit on 12/1/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields


class UserHomePageViewController: UIViewController {

    @IBOutlet weak var GetProdsButton: UIButton!
    @IBOutlet weak var Product: UILabel!
    @IBOutlet weak var id: MDCFilledTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn(label: "id", placeholder: "id", btn: id)
        
/*-----------------------------------Session-----------------------------------*/
        /*let def = UserDefaults.standard

        let log = def.string(forKey: "login")
        print(log)
        let log = def.removeObject(forKey: "login")
        print(log)
*/
        
        let userDef = UserDefaults.standard
        if let savedPerson = userDef.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            let loadedPerson = try? decoder.decode(UserModel.self, from: savedPerson)
            print(loadedPerson!.id ?? "null value")
            
        }

    }

    @IBAction func onClick(_ sender: UIButton) {

            ProductController.getById(id: id.text ?? ""){ data in
            // Do your stuff here
            print(data[0]["name"])
                self.Product.text = data[0]["name"].string
        }
        
    }
    
    
    func btn(label: String, placeholder: String,btn:MDCFilledTextField!)
    {
        btn.label.text = label
        btn.placeholder = placeholder
        btn.center = self.view.center
        btn.sizeToFit()
    }

}

