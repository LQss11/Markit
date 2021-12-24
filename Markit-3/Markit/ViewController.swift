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
class ViewController: UIViewController {

    @IBOutlet weak var Password: MDCFilledTextField!
    @IBOutlet weak var Username: MDCFilledTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        btn(label: "Username", placeholder: "Username", btn: Username)
        btn(label: "Password", placeholder: "Password", btn: Password)
        //let u = UserModel.init(firstname: "xxsxsxsxsxsxsxs", lastname: "", username: "", mail: "", birthday: "", password: "", gender: "", role: "", phone: "", address: "", state: 1)
        
        
        //UserController.Post(u:u)
        //UserController.Login()
       /*
        let data: [String: Any] = ["firstname":"xxxxxxxxxxxxxx","lastname":"Affes","username":"LQss","mail":"salem.affes@esprit.tn","birthday":"0000-00-00","password":"test","gender":"Male","role":"MANAGER","phone":"55323442","address":"address","state":"1","company":"1"]
        
        AF.request("http://172.19.26.142:3000/user", method: .post, parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            
            case .success(let value):
                print("Alamo value: \(value)")
                break
            case .failure(let error):
                print("Alamo error: \(error)")
                break
            }
        }
        */
        
        /*
        super.viewDidLoad()
        // 1
        let request = AF.request("http://172.19.26.142:3000/login/LQss/azerty123")
        // 2
        request.responseJSON { (data) in
          print(data)
        }*/
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

