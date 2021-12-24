//
//  TableViewCell.swift
//  Markit
//
//  Created by Affes Salem on 12/15/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
class ProductCell: UITableViewCell {

    @IBOutlet weak var userPeoductImage: UIImageView!
    @IBOutlet weak var userProductName: UILabel!
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!

    func setProduct(product: ProductModel) {
        
        let url = URL(string: Statics.IMGURL+product.image!+".jpg")!

        // Fetch Image Data
        if let data = try? Data(contentsOf: url) {
            // Create Image and Update Image View
            productImage.image = UIImage(data: data)
            productImage.contentMode = .scaleAspectFit

        }
        productName.text = product.name
    }

    func userSetProduct(product: ProductModel) {
        
        let url = URL(string: Statics.IMGURL+product.image!+".jpg")!

        // Fetch Image Data
        if let data = try? Data(contentsOf: url) {
            // Create Image and Update Image View
            userPeoductImage.image = UIImage(data: data)
            userPeoductImage.contentMode = .scaleAspectFit

        }
        userProductName.text = product.name
    }
    
    
}
