//
//  AddEmployeeViewController.swift
//  Markit
//
//  Created by Affes Salem on 1/2/21.
//  Copyright © 2021 ESPRIT. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextFields
import Alamofire
class AddEmployeeViewController: UIViewController {
    
    var image_data : NSURL?

    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var gender: MDCFilledTextField!
    @IBOutlet weak var birthday: MDCFilledTextField!
    @IBOutlet weak var phone: MDCFilledTextField!
    @IBOutlet weak var address: MDCFilledTextField!
    @IBOutlet weak var mail: MDCFilledTextField!
    
    @IBOutlet weak var password: MDCFilledTextField!
    @IBOutlet weak var username: MDCFilledTextField!
    @IBOutlet weak var lastname: MDCFilledTextField!
    @IBOutlet weak var firstname: MDCFilledTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    @IBAction func addEmp(_ sender: UIButton) {
        
        let userDef = UserDefaults.standard
        if let savedPerson = userDef.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            let loadedPerson = try? decoder.decode(UserModel.self, from: savedPerson)
            let u = UserModel.init(firstname: firstname.text, lastname: lastname.text, username: username.text, mail: mail.text, birthday: birthday.text, password: password.text, gender: gender.text, role: "EMPLOYEE", phone: "", address: "", state: "1", company:loadedPerson!.company!)
        
            UserController.PostIM(u: u, im: (self.image_data?.filePathURL)!)
            let alert = UIAlertController(title: "Notice", message: "Employee Added!" , preferredStyle: UIAlertController.Style.alert)
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

extension   AddEmployeeViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        
        self.image_data = info[.imageURL] as! NSURL?
        self.imageview.image = info[.originalImage] as! UIImage?
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
