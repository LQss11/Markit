//
//  ProductModel.swift
//  Markit
//
//  Created by Esprit on 12/5/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit

class CompanyModel: NSObject,Codable {

    internal init( name: String?, address: String?, activity: String?) {
        self.name = name
        self.address = address
        self.activity = activity
    }
    
    var id: String?
    var name: String?
    var address: String?
    var activity: String?
}
