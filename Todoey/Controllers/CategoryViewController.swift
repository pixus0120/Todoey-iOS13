//
//  CategoryViewController.swift
//  Todoey
//
//  Created by locussigilli on 5/25/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - TableView Datasource Methods  1.
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title

        cell.accessoryType = item.done ? .checkmark : .none    ////
        
        return cell
    }
    

    //MARK: - Data Manipulation Methods  2.
        
    func saveItems(){       //save data to DB
        
            do {
                try context.save()
            } catch {
                print("Error saving content, \(error)")
            }
            self.tableView.reloadData()
        }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){     // load, read data from DB
                do {
                    itemArray = try context.fetch(request)
                } catch {
                    print("Erorr ferching context data: \(error)")
                }
            }
    
    //MARK: - Add New Categories
    
@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField()
    
    let alert = UIAlertController(title: "Add New ToDoList Item", message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        
        let newItem = Item(context: self.context)
        newItem.title = textField.text!
        newItem.done = false
        self.itemArray.append(newItem)
        
     //   self.defaults.set(self.itemArray, forKey: "TodoListArray")   //local storage   singelton
        self.saveItems()
    }
    
    alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create new item"
        textField = alertTextField
    }
}
}
