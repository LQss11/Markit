//
//  UserController.swift
//  Markit
//
//  Created by Esprit on 11/30/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import Alamofire
import SwiftyJSON
class CompanyController {
    /*------------------------------------------POST------------------------------------------*/

    class public func Post(u:CompanyModel)
    {

        let data: [String: Any] = ["name":u.name,"address":u.address,"activity":u.activity]
        AF.request(Statics.URL+"/company", method: .post, parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
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
    /*------------------------------------------Get Last------------------------------------------*/
    
    class public func getLast(completion: @escaping (JSON) -> Void)
    {
        
        AF.request(Statics.URL+"/companylast/").responseJSON { response in

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
    
   
}
