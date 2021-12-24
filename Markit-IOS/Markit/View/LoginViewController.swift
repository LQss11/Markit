//
//  ViewController.swift
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

import Alamofire
class LoginViewController: UIViewController {

    
    @IBOutlet weak var Password: MDCFilledTextField!
    @IBOutlet weak var Username: MDCFilledTextField!
    
    @IBOutlet weak var signUpAdminButton: UIButton!
    @IBOutlet weak var forgotPass: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        btn(label: "Username", placeholder: "Username", btn: Username)
        btn(label: "Password", placeholder: "Password", btn: Password)
        Password.isSecureTextEntry = true
        
        //let p = ProductModel(name: "nametext")
        //ProductController.Put(id: "208", u: p)
        //ProductController.delProduct(id: "211")
        
    }
    
    @IBAction func SignUp(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpStoryboard") as! SignUpViewController
        self.present(vc, animated: true,completion: nil)
    }
    
    @IBAction func ForgotPassword(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordView") as! ForgotPaasswordController
        self.present(vc, animated: true,completion: nil)
    }
        
    @IBAction func SignUpAdmin(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpAdminStoryboard") as! SignUpAdminViewController
        self.present(vc, animated: true,completion: nil)
    }
    
    @IBAction func SignIn(_ sender: UIButton) {
         
        UserController.Login(username: Username.text ?? "", password: Password.text ?? ""){ data in
            // Do your stuff here
            if(!data["object"].exists())
            {
                if (data["state"].stringValue=="1")
                {

                    let defaults = UserDefaults.standard
                    defaults.set("isLogin", forKey: "login")
                                
                    let u = UserModel.init(id: data["id"].stringValue,firstname: data["firstname"].stringValue, lastname: data["lastname"].stringValue, username: data["username"].stringValue, mail: data["mail"].stringValue, birthday: data["birthday"].stringValue, password: data["password"].stringValue, gender: data["gender"].stringValue, role: data["role"].stringValue, phone: data["phone"].stringValue, address: data["address"].stringValue, state: data["state"].stringValue,company: data["company"].stringValue, image:data["image"].stringValue)
                    
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(u) {
                        let defaults = UserDefaults.standard
                        defaults.set(encoded, forKey: "user")
                        
                    }
                    
                    if (data["role"].stringValue=="USER") {self.performSegue(withIdentifier: "userSegue", sender: "")}
                    else if(data["role"].stringValue=="MANAGER") {self.performSegue(withIdentifier: "adminSegue", sender: "")}
                    else if(data["role"].stringValue=="EMPLOYEE") {self.performSegue(withIdentifier: "employeeSegue", sender: "")}
                    else{print("Role not assigned")}
                                       
                }
                else
                {
                    print(data["User is disabled"])

                }
            }
            else
            {
/*
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "test") as! VideoListScreen
                self.present(vc, animated: true,completion: nil)*/
                //print("Incorrect Username or password")
            }
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
}

