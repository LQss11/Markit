//
//  User.swift
//  Markit
//
//  Created by Esprit on 11/30/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import Foundation



class AddOnItems {
    

    
    var id: Int?
    var firstname: String?
    var lastname: String?
    var username: String?
    var mail: String?
    var birthday: String?
    var password: String?
    var gender: String?
    var role: String?
    var phone: String?
    var address: String?
    var state: Int?
    var company: Int?
    
    internal init(firstname: String?, lastname: String?, username: String?, mail: String?, birthday: String?, password: String?, gender: String?, role: String?, phone: String?, address: String?, state: Int?, company: Int?) {
        self.firstname = firstname
        self.lastname = lastname
        self.username = username
        self.mail = mail
        self.birthday = birthday
        self.password = password
        self.gender = gender
        self.role = role
        self.phone = phone
        self.address = address
        self.state = state
        self.company = company
    }
    


    

 }
