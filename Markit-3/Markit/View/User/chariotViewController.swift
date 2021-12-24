//
//  chariotViewController.swift
//  Markit
//
//  Created by Esprit on 1/8/21.
//  Copyright © 2021 ESPRIT. All rights reserved.
//

import UIKit
import CoreData
class chariotViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
     
        //var
        var favorites = [String]()
    var prices = [String]()
    
    var name:String?
    var price:String?
    var image:String?
        

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favorites.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let favCell = tableView.dequeueReusableCell(withIdentifier: "favCell")
            let contentView = favCell?.contentView
            
            let label = contentView?.viewWithTag(1) as! UILabel
            let label1 = contentView?.viewWithTag(3) as! UILabel
            let imageView = contentView?.viewWithTag(2) as! UIImageView
            
            label.text = favorites[indexPath.row]
            label1.text = prices[indexPath.row]
            imageView.image = UIImage(named: favorites[indexPath.row])
            

            return favCell!
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let movie = favorites[indexPath.row]
            performSegue(withIdentifier: "mSegue2", sender: movie)
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                
                deleteElement(tableView: tableView, index: indexPath.row)
                print("CELL DELETING ...")
                
            }
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            let param = sender as! String
            if segue.identifier == "mSegue2" {
                
            }
        }
        

        override func viewDidLoad() {
            super.viewDidLoad()
            fetchData()
            // Do any additional setup after loading the view.
        }
        
        
        func fetchData() {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let persistentContainer = appDelegate.persistentContainer
            let managedContext = persistentContainer.viewContext
            
            let request = NSFetchRequest<NSManagedObject>(entityName: "Product")
            
            do {
                
                let data = try managedContext.fetch(request)
                for item in data {
                    
                    favorites.append(item.value(forKey: "price") as! String)
                    
          prices.append(item.value(forKey: "name") as! String)
                    
                }
                
            } catch  {
                
                print("Fetching error !")
            }
            
        }
        

        func getByCreateria(movieName: String) -> NSManagedObject{
            
            var movieExist:NSManagedObject?
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let persistentContainer = appDelegate.persistentContainer
            let managedContext = persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
            let predicate = NSPredicate(format: "price = %@", movieName)
            request.predicate = predicate
            
            do {
                let result = try managedContext.fetch(request)
                if result.count > 0 {
                    
                    movieExist = (result[0] as! NSManagedObject)
                    print("Product exists !")
                    
                }
                
            } catch {
                
                print("Fetching by criteria error !")
            }
            
            
            return movieExist!
        }
        
        
        func deleteElement(tableView: UITableView, index: Int) {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let persistentContainer = appDelegate.persistentContainer
            let managedContext = persistentContainer.viewContext
            
            let object = getByCreateria(movieName: favorites[index])
            managedContext.delete(object)
            favorites.remove(at: index)
            
            tableView.reloadData()
                    
        }

    @IBAction func calculPrice(_ sender: Any) {
        
        func count(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favorites.count
        }
        var s:Int?
        var x:Int?
        s = 0
        for i in favorites {
            let x =   Int(i)
            s = s! + x!
            print(s)
        }
        
        
        let somme = String(s!)
        let alert = UIAlertController(title: "MarkIT", message: "Price total is " + somme, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}

