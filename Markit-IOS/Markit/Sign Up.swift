//
//  Sign Up.swift
//  Markit
//
//  Created by ESPRIT on 11/28/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit


import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class Sign_Up: UIViewController {

    @IBOutlet weak var FirstName: MDCFilledTextField!
    @IBOutlet weak var LastName: MDCFilledTextField!
    @IBOutlet weak var Username: MDCFilledTextField!
    @IBOutlet weak var Password: MDCFilledTextField!
    @IBOutlet weak var Mail: MDCFilledTextField!
    @IBOutlet weak var Gender: MDCFilledTextField!
    @IBOutlet weak var Birthdate: MDCFilledTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        btn(label: "FirstName", placeholder: "FirstName", btn: FirstName)
        btn(label: "LastName", placeholder: "LastName", btn: LastName)
        btn(label: "Username", placeholder: "Username", btn: Username)
        btn(label: "Password", placeholder: "Password", btn: Password)
        btn(label: "Mail", placeholder: "Mail", btn: Mail)
        btn(label: "Gender", placeholder: "Gender", btn: Gender)
        btn(label: "BirthDate", placeholder: "BirthDate", btn: Birthdate)
        
        
        
    }
    
    
    func btn(label: String, placeholder: String,btn:MDCFilledTextField!)
    {
        btn.label.text = label
        btn.placeholder = placeholder
        btn.center = self.view.center
        
        //test.leadingAssistiveLabel.text = "This is helper text"
        btn.sizeToFit()
    }
}
