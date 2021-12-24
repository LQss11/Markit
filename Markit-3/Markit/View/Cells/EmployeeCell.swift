//
//  EmployeeCell.swift
//  Markit
//
//  Created by Affes Salem on 1/1/21.
//  Copyright © 2021 ESPRIT. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {


    @IBOutlet weak var empImage: UIImageView!
    @IBOutlet weak var empName: UILabel!
    func setEmployee(emp: UserModel) {
        
        let url = URL(string: Statics.IMGURL+emp.image!+".jpg")!

        // Fetch Image Data
        if let data = try? Data(contentsOf: url) {
            // Create Image and Update Image View
            empImage.image = UIImage(data: data)
            empImage.contentMode = .scaleAspectFit

        }

        empName.text = emp.username
    }

}
