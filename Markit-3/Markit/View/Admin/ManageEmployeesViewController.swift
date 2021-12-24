//
//  ManageEmployeesViewController.swift
//  Markit
//
//  Created by Affes Salem on 1/1/21.
//  Copyright © 2021 ESPRIT. All rights reserved.
//

import UIKit
import SwiftyJSON

class ManageEmployeesViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var addEmp: UIButton!
    
    var users: [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserController.getUsers{ data in
            if let arr = data.arrayObject as? [[String:AnyObject]] {
                for items in arr{
                    let user = UserModel(image: items["image"] as? String, id: String(items["id"] as? Int64 ?? 0), firstname: items["firstname"] as? String, lastname: items["lastname"] as? String, username: items["username"] as? String, mail: items["mail"] as? String, phone: items["phone"] as? String, address: items["address"] as? String, company: items["company"] as? String
                    )

                    //print(items["id"])

                    /*let prod1 = ProductModel(name: items["name"] as? String )*/
                    let userDef = UserDefaults.standard
                    if let savedPerson = userDef.object(forKey: "user") as? Data {
                        let decoder = JSONDecoder()
                        let loadedPerson = try? decoder.decode(UserModel.self, from: savedPerson)
                        if(items["role"] as! String=="EMPLOYEE" && items["company"]!.stringValue == loadedPerson!.company)
                        {
                            
                                self.users.append(user)
                                    print("COMPANYYYYYY")

                                    print(items["company"])
                            

                        }
                    }

                    //print(prod1.name ?? "aaaa")
                }
            }
            self.tableview.reloadData()
        }
    }


}


extension ManageEmployeesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    


    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmpCell") as! EmployeeCell
        cell.setEmployee(emp: user)
               
        return cell
    }
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.cellForRow(at: indexPath) as? EmployeeCell) != nil {
            //ProductController.delProduct(id: products[indexPath.row].id ?? 0)

            //self.tableView.reloadData()
            let u = UserModel.init(image: users[indexPath.row].image, id: users[indexPath.row].id, firstname: users[indexPath.row].firstname, lastname: users[indexPath.row].lastname, username: users[indexPath.row].username, mail: users[indexPath.row].mail, phone: users[indexPath.row].phone, address: users[indexPath.row].address, company:users[indexPath.row].company)

            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(u) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "emp")
            }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewEmployeeStoryboard") as! ViewEmployeeViewController
              self.present(vc, animated: true,completion: nil)
            

        }

    }
    
    
    
    @IBAction func addEmployee(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddEmployeeStoryboard") as! AddEmployeeViewController
          self.present(vc, animated: true,completion: nil)
        
    }
}
