//
//  ProductModel.swift
//  Markit
//
//  Created by Esprit on 12/5/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit

class ProductModel: NSObject,Codable {


    internal init(name: String?, price: String?, total: String?, dateadded: String?, barcode: String?, desc: String?, category: String?, company: String?) {
        self.name = name
        self.price = price
        self.total = total
        self.dateadded = dateadded
        self.barcode = barcode
        self.desc = desc
        self.category = category
        self.company = company

    }
    internal init(id: Int?, name: String?, price: String?, total: String?, dateadded: String?, barcode: String?, desc: String?, category: String?, image: String?, company: String?) {
        self.id = id
        self.name = name
        self.price = price
        self.total = total
        self.dateadded = dateadded
        self.barcode = barcode
        self.desc = desc
        self.category = category
        self.company = company
        self.image = image
    }
    
    internal init(name: String?, price: String?, total: String?, barcode: String?, desc: String?, image: String?) {
        self.name = name
        self.price = price
        self.total = total
        self.barcode = barcode
        self.desc = desc
        self.image = image
    }
    
    internal init( name: String?, price: String?, total: String?, dateadded: String?, barcode: String?, desc: String?) {
        self.name = name
        self.price = price
        self.total = total
        self.dateadded = dateadded
        self.barcode = barcode
        self.desc = desc
    }
    var id: Int?
    var name: String?
    var price: String?
    var total: String?
    var dateadded: String?
    var barcode: String?
    var desc: String?
    var category: String?
    var image: String?
    var company: String?

}
