//
//  UserModel.swift
//  Markit
//
//  Created by Esprit on 11/30/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
class UserModel : NSObject,Codable {
    

    //modify
    internal init(firstname: String?, lastname: String?, username: String?, mail: String?, phone: String?, address: String?) {
        self.firstname = firstname
        self.lastname = lastname
        self.username = username
        self.mail = mail
        self.phone = phone
        self.address = address
    }
    
    //show emps
    internal init(image: String?, id: String?, firstname: String?, lastname: String?, username: String?, mail: String?, phone: String?, address: String?, company: String?) {
        self.image = image
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.username = username
        self.mail = mail
        self.phone = phone
        self.address = address
        self.company = company

    }
    
    
    internal init(  id: String?,firstname: String?, lastname: String?, username: String?, mail: String?, birthday: String?, password: String?, gender: String?, role: String?, phone: String?, address: String?, state: String?, company: String?, image: String?) {
        self.id = id
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
        self.image = image

    }
    //add emp
    internal init( firstname: String?, lastname: String?, username: String?, mail: String?, birthday: String?, password: String?, gender: String?, role: String?, phone: String?, address: String?, state: String?, company: String?) {
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
        var id: String?
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
        var state: String?
        var company: String?
        var image: String?


    /*
         internal init(id: Int?, firstname: String?, lastname: String?, username: String?, mail: String?, birthday: String?, password: String?, gender: String?, role: String?, phone: String?, address: String?, state: Int?, company: Int?) {
            self.id = id
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
        }*/
}
