//
//  UserController.swift
//  Markit
//
//  Created by Esprit on 11/30/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import Alamofire
import SwiftyJSON
class UserController {
    
    
    
    
    
    
    
    
    /*------------------------------------------POSTIM------------------------------------------*/

    class public func PostIM(u:UserModel,im:URL)
    {
        
       /* ["firstname":u.firstname,"lastname":u.lastname,"username":u.username,"mail":u.mail,"birthday":u.birthday,"password":u.password,"gender":u.gender,"role":u.role,"phone":u.phone,"address":u.address,"state":u.state,"company":"1"]*/
        let nowDouble = String(Int64(NSDate().timeIntervalSince1970)*1000)
         
        let data: [String: Any] = ["firstname":u.firstname,"lastname":u.lastname,"username":u.username,"mail":u.mail,"birthday":u.birthday,"password":u.password,"gender":u.gender,"role":u.role,"phone":u.phone,"address":u.address, "state" : u.state, "company": u.company, "image": nowDouble]
        AF.request(Statics.URL+"/user", method: .post, parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {

            case .success(let value):
                
                
                
                
                print("Alamo value: \(value)")
                break
            case .failure(let error):
                print("Alamo error: \(error)")
                break
            }
        }
        
        let url = Statics.URL+"/user"
            let headers: HTTPHeaders
            headers = ["Content-type": "multipart/form-data",
                       "Content-Disposition" : "form-data"]
            
            AF.upload(multipartFormData: { (multipartFormData) in
                
                multipartFormData.append((im), withName: "image", fileName: nowDouble+".jpg", mimeType: "image/jpeg")
                
                
                
            }, to: url, usingThreshold: UInt64.init(),
               
               method: .post,
               headers: headers).response{ response in
                
                if((response.error != nil)){
                    do{
                        if let jsonData = response.data{
                            let parsedData = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
                            print(parsedData)
                            
                            
                            
                        }
                    }catch{
                        print("error message")
                    }
                }else{
                    print(response.error)
                }
            }
        
    }

    /*------------------------------------------POST------------------------------------------*/

    class public func PostAdmin(u:UserModel,im:URL)
    {
        
       /* ["firstname":u.firstname,"lastname":u.lastname,"username":u.username,"mail":u.mail,"birthday":u.birthday,"password":u.password,"gender":u.gender,"role":u.role,"phone":u.phone,"address":u.address,"state":u.state,"company":"1"]*/
        let nowDouble = String(Int64(NSDate().timeIntervalSince1970)*1000)

        let data: [String: Any] = ["firstname":u.firstname,"lastname":u.lastname,"username":u.username,"mail":u.mail,"birthday":u.birthday,"password":u.password,"gender":u.gender,"role":u.role,"phone":u.phone,"address":u.address, "state" : "0","company":u.company, "image": nowDouble]
        AF.request(Statics.URL+"/user", method: .post, parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {

            case .success(let value):
                print("Alamo value: \(value)")
                break
            case .failure(let error):
                print("Alamo error: \(error)")
                break
            }
        }
        
        
        
        let url = Statics.URL+"/user"
            let headers: HTTPHeaders
            headers = ["Content-type": "multipart/form-data",
                       "Content-Disposition" : "form-data"]
            
            AF.upload(multipartFormData: { (multipartFormData) in
                
                multipartFormData.append((im), withName: "image", fileName: nowDouble+".jpg", mimeType: "image/jpeg")
                
                
                
            }, to: url, usingThreshold: UInt64.init(),
               
               method: .post,
               headers: headers).response{ response in
                
                if((response.error != nil)){
                    do{
                        if let jsonData = response.data{
                            let parsedData = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
                            print(parsedData)
                            
                            
                            
                        }
                    }catch{
                        print("error message")
                    }
                }else{
                    print(response.error)
                }
            }
        
    }
    
    /*------------------------------------------LOGIN------------------------------------------*/
    
    class public func Login(username:String , password:String,completion: @escaping (JSON) -> Void)
    {
        
        AF.request(Statics.URL+"/login/"+username+"/"+password).responseJSON { response in
            //debugPrint(response)
            //print(response)
            
            if let json = response.data {
                do{
                    let data = try JSON(data: json)
                    
                            completion(data)
                    
                }catch{
                    print(error)
                }
            }
        }

    }
    
    class public func forgotpassword(mail:String)
    {
        
        let data: [String: Any] = ["mail":mail]
        AF.request(Statics.URL+"/user/forgotpassword/", method: .put, parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {

            case .success(let value):
                print("Alamo value: \(value)")
                break
            case .failure(let error):
                print("Alamo error: \(error)")
                break
            }
        }
    }
    
    class public func Put(id:String,u:UserModel)
    {
        
        let data: [String: Any] = ["mail":u.mail,"username":u.username, "firstname":u.firstname, "lastname":u.lastname, "phone":u.phone, "address":u.address]
        print(Statics.URL+"/user/"+id)
        AF.request(Statics.URL+"/user/"+String(id), method: .put, parameters: data).responseJSON { (response) in
            switch response.result {

            case .success(let value):
                print("Alamo value: \(value)")
                break
            case .failure(let error):
                print("Alamo error: \(error)")
                break
            }
        }
    }
    
    
    class public func Put2(id:String, u:UserModel)
    {
        let data: [String: Any] =
            ["mail":u.mail,"username":u.username, "firstname":u.firstname, "lastname":u.lastname, "phone":u.phone, "address":u.address]
        AF.request(Statics.URL+"/user/"+id, method: .put, parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {

            case .success(let value):
                print("Alamo value: \(value)")
                break
            case .failure(let error):
                print("Alamo error: \(error)")
                break
            }
        }
    }
    
    
    /*------------------------------------------GetProducts------------------------------------------*/
    class public func getUsers(completion: @escaping (JSON) -> Void)
    {
        AF.request(Statics.URL+"/user/").responseJSON { response in
            if let json = response.data {
                do{
                    let data = try JSON(data: json)
                    completion(data)
                }catch{
                    print(error)
                }
            }
        }
    }
    /*------------------------------------------Delete------------------------------------------*/
    class public func delUser(id:String)
    {
        AF.request(Statics.URL+"/user/"+id, method: .delete, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
        }
    }
    
}
