//
//  SignUpViewController.swift
//  Markit
//
//  Created by Esprit on 11/30/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit


import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class SignUpViewController: UIViewController {
    
    var image_data : NSURL?

    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var FirstName: MDCFilledTextField!
       @IBOutlet weak var LastName: MDCFilledTextField!
       @IBOutlet weak var Username: MDCFilledTextField!
       @IBOutlet weak var Password: MDCFilledTextField!
       @IBOutlet weak var Mail: MDCFilledTextField!
       @IBOutlet weak var Gender: MDCFilledTextField!
       @IBOutlet weak var Birthdate: MDCFilledTextField!
    
    
    @IBOutlet weak var SignUpButton: UIButton!
    override func viewDidLoad() {
           super.viewDidLoad()

           
           btn(label: "FirstName", placeholder: "FirstName", btn: FirstName)
           btn(label: "LastName", placeholder: "LastName", btn: LastName)
           btn(label: "Username", placeholder: "Username", btn: Username)
           btn(label: "Password", placeholder: "Password", btn: Password)
           btn(label: "Mail", placeholder: "Mail", btn: Mail)
           btn(label: "Gender", placeholder: "Gender", btn: Gender)
           btn(label: "BirthDate", placeholder: "BirthDate", btn: Birthdate)
           
           btn(label: "Username", placeholder: "Username", btn: Username)
           btn(label: "Password", placeholder: "Password", btn: Password)
        Password.isSecureTextEntry = true
        
           
       }
       

    @IBAction func SignUp(_ sender: UIButton) {

          let u = UserModel.init(firstname: FirstName.text, lastname: LastName.text, username: Username.text, mail: Mail.text, birthday: Birthdate.text, password: Password.text, gender: Gender.text, role: "USER", phone: "", address: "", state: "0", company: nil)
        
          UserController.PostIM(u: u, im: (self.image_data?.filePathURL)!)
        let alert = UIAlertController(title: "Register", message: "Thank you for subscribing!" , preferredStyle: UIAlertController.Style.alert)
                                           alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                           self.present(alert, animated: true, completion: nil)
    }
    
    
    func btn(label: String, placeholder: String,btn:MDCFilledTextField!)
       {
           btn.label.text = label
           btn.placeholder = placeholder
           btn.center = self.view.center
        
           //test.leadingAssistiveLabel.text = "This is helper text"
           btn.sizeToFit()
       }
    @IBAction func didTapButton(_ sender: UIButton) {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;

        myPickerController.sourceType =  UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
           
    }
}

extension   SignUpViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        
        self.image_data = info[.imageURL] as! NSURL?
        self.imageview.image = info[.originalImage] as! UIImage?
        self.dismiss(animated: true, completion: nil)
        
    }
    
}


