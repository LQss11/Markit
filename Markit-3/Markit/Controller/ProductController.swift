//
//  UserController.swift
//  Markit
//
//  Created by Esprit on 11/30/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import Alamofire
import SwiftyJSON
class ProductController {
    /*------------------------------------------POST------------------------------------------*/

    class public func Post(u:ProductModel,im:URL)
    {
        
        let nowDouble = String(Int64(NSDate().timeIntervalSince1970)*1000)

        let data: [String: Any] = ["name":u.name,"price":u.price,"total":u.total,"dateadded":u.dateadded,"barcode":u.barcode,"description":u.desc,"category":u.category,"company":u.company, "image": nowDouble]
        AF.request(Statics.URL+"/product", method: .post, parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {

            case .success(let value):
                print("Alamo value: \(value)")
                break
            case .failure(let error):
                print("Alamo error: \(error)")
                break
            }
        }
        
        let url = Statics.URL+"/product"
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
    
    class public func getById(id:String,completion: @escaping (JSON) -> Void)
    {
        AF.request(Statics.URL+"/product/"+id).responseJSON { response in
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
    
    
    /*------------------------------------------getbybarcode------------------------------------------*/
    
    class public func getByBarcode(barcode:String,completion: @escaping (JSON) -> Void)
    {
        AF.request(Statics.URL+"/product/"+barcode).responseJSON { response in
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
    
    
    
    
    /*------------------------------------------GetProducts------------------------------------------*/
    class public func getProducts(completion: @escaping (JSON) -> Void)
    {
        AF.request(Statics.URL+"/product/").responseJSON { response in
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
    /*------------------------------------------PUT------------------------------------------*/
    class public func Put(id:Int, u:ProductModel)
    {
        let data: [String: Any] = ["name":u.name,"price":u.price,"total":u.total,"barcode":u.barcode,"description":u.desc]
        print(Statics.URL+"/product/"+String(id))
        AF.request(Statics.URL+"/product/"+String(id), method: .put, parameters: data, encoding: JSONEncoding.default).responseJSON { (response) in
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
    
    
    
    
    
    /*------------------------------------------Delete------------------------------------------*/
    class public func delProduct(id:Int)
    {
        AF.request(Statics.URL+"/product/"+String(id), method: .delete, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
        }
    }

}
