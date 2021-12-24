//
//  SignUpAdminViewController.swift
//  Markit
//
//  Created by Esprit on 12/7/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextFields

class SignUpAdminViewController: UIViewController {

    
    var image_data : NSURL?

    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var Firstname: MDCFilledTextField!
    @IBOutlet weak var Lastname: MDCFilledTextField!
    @IBOutlet weak var Username: MDCFilledTextField!
    @IBOutlet weak var Password: MDCFilledTextField!
    @IBOutlet weak var Mail: MDCFilledTextField!
    @IBOutlet weak var Address: MDCFilledTextField!
    @IBOutlet weak var Birthday: MDCFilledTextField!
    @IBOutlet weak var Phone: MDCFilledTextField!
    @IBOutlet weak var Gender: MDCFilledTextField!
    
    
    @IBOutlet weak var CompanyName: MDCFilledTextField!
    @IBOutlet weak var CompanyAddress: MDCFilledTextField!
    @IBOutlet weak var CompanyActivity: MDCFilledTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn(label: "Firstname", placeholder: "Firstname", btn: Firstname)
        btn(label: "Lastname", placeholder: "Lastname", btn: Lastname)
        btn(label: "Username", placeholder: "Username", btn: Username)
        btn(label: "Password", placeholder: "Password", btn: Password)
        btn(label: "Mail", placeholder: "Mail", btn: Mail)
        btn(label: "Address", placeholder: "Address", btn: Address)
        btn(label: "Birthday", placeholder: "Birthday", btn: Birthday)
        btn(label: "Phone", placeholder: "Phone", btn: Phone)
        btn(label: "Gender", placeholder: "Gender", btn: Gender)
        Password.isSecureTextEntry = true

        btn(label: "CompanyName", placeholder: "CompanyName", btn: CompanyName)
        btn(label: "CompanyAddress", placeholder: "CompanyAddress", btn: CompanyAddress)
        btn(label: "CompanyActivity", placeholder: "CompanyActivity", btn: CompanyActivity)

        
        
        /*
        let u = UserModel.init(firstname: Firstname.text, lastname: Lastname.text, username: Username.text, mail: Mail.text, birthday: Birthday.text, password: Password.text, gender: Gender.text, role: "MANAGER", phone: Phone.text, address: Address.text, state: "0",company: "IOS2")
        UserController.Post(u: u)
         print(u.company)
*/
        
    }
    
    @IBAction func SignUpAdmin(_ sender: UIButton) {
                  let c = CompanyModel.init(name: CompanyName.text, address: CompanyAddress.text, activity: CompanyActivity.text)
        CompanyController.Post(u: c)
        
     CompanyController.getLast(){ data in
     print(data[0]["id"])
        let u = UserModel.init(firstname: self.Firstname.text, lastname: self.Lastname.text, username: self.Username.text, mail: self.Mail.text, birthday: self.Birthday.text, password: self.Password.text, gender: self.Gender.text, role: "MANAGER", phone: self.Phone.text, address: self.Address.text, state: "0",company: String(data[0]["id"].int!) )
     UserController.PostAdmin(u: u, im: (self.image_data?.filePathURL)!)

        
         let alert = UIAlertController(title: "Register", message: "Thank you for subscribing!" , preferredStyle: UIAlertController.Style.alert)
                                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                            self.present(alert, animated: true, completion: nil)
        
 }

    }
    
    func btn(label: String, placeholder: String,btn:MDCFilledTextField!)
    {
        btn.label.text = label
        btn.placeholder = placeholder
        btn.center = self.view.center
        //test.leadingAssistiveLabel.text = "This is helper text"
        btn.sizeToFit()
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;

        myPickerController.sourceType =  UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
           
        
    }
}


extension   SignUpAdminViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        
        self.image_data = info[.imageURL] as! NSURL?
        self.imageview.image = info[.originalImage] as! UIImage?
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
