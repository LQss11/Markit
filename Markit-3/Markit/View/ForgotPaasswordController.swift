//
//  ForgotPaasswordController.swift
//  Markit
//
//  Created by Esprit on 12/5/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextControls_FilledTextAreas

class ForgotPaasswordController: UIViewController {

    @IBOutlet weak var mail: MDCFilledTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

               
    }

    @IBAction func changePass(_ sender: UIButton) {
        UserController.forgotpassword(mail: mail.text ?? "")
        let alert = UIAlertController(title: "NOTICE!", message: "Check your email!" , preferredStyle: UIAlertController.Style.alert)
                                           alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                           self.present(alert, animated: true, completion: nil)
    }
}
