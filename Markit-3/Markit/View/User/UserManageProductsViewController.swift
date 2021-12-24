//
//  ManageProductsViewController.swift
//  Markit
//
//  Created by Esprit on 12/9/20.
//  Copyright © 2020 ESPRIT. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserManageProductsViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    
    
    var products: [ProductModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ProductController.getProducts(){ data in
            if let arr = data.arrayObject as? [[String:AnyObject]] {
                for items in arr{
                    let prod = ProductModel(id: items["id"] as? Int,name: items["name"] as? String, price: String(items["price"] as? Int64 ?? 0), total: String(items["total"] as? Int64 ?? 0), dateadded: items["dateadded"] as? String, barcode: String(items["barcode"] as? Int64 ?? 0), desc: items["description"] as? String, category: items["category"] as? String, image: items["image"] as? String ,company: items["company"] as? String)
                    //print(items["id"])

                    /*let prod1 = ProductModel(name: items["name"] as? String )*/
                    self.products.append(prod)
                    print(prod.name ?? "aaaa")
                }
            }
            self.tableView.reloadData()
        }
    }
    /*
    @IBAction func addProductButton(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddProductStoryboard") as! AddProductViewController
          self.present(vc, animated: true,completion: nil)
        
    }
*/
}


extension UserManageProductsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return products.count
    }
    


    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! ProductCell
        cell.userSetProduct(product: product)
               
        return cell
    }
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.cellForRow(at: indexPath) as? ProductCell) != nil {
            //ProductController.delProduct(id: products[indexPath.row].id ?? 0)

            //self.tableView.reloadData()
            let u = ProductModel.init(id: products[indexPath.row].id, name: products[indexPath.row].name, price: products[indexPath.row].price, total: products[indexPath.row].total, dateadded: products[indexPath.row].dateadded, barcode: products[indexPath.row].barcode, desc: products[indexPath.row].desc, category: products[indexPath.row].category, image: products[indexPath.row].image, company: products[indexPath.row].company)
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(u) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "product")
            }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserViewProductStoryboard") as! UserViewProductViewController
              self.present(vc, animated: true,completion: nil)
            

        }

    }
    
    
    
}
