//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    
    var itemArray = [Item]() //  let defaults = UserDefaults.standard  //storage local singelton
 //   let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)  //.first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
//        let newItem = Item()
//        newItem.title = "Find mike"
//        itemArray.append(newItem)

        
//        loadItems()
        //load saved array data
  //      if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
  //          itemArray = items
  //      }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //ternary operator ==>
        // value = condition ? valueIfTRUE : valueIfFALSE
        cell.accessoryType = item.done ? .checkmark : .none    ////
        
    /*    if item.done == true {   ///
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none             ///
        }    */
        return cell
    }
    
    //MARK: - Table View Delegate Mathod
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
      //  itemArray[indexPath.row].done
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done  /// oposite !!!

        saveItems()
        
        
  //      tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK: - Add new Item Button
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoList Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happend once the user clicks the Add Item button on our UIAlert
            
        //    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
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
        
        alert.addAction(action)
            present(alert, animated: true, completion: nil)
    }

//MARK: - Model Manipulation Methods
    
    func saveItems(){
    
        do {
            try context.save()
        } catch {
            print("Error saving content, \(error)")
        }
    tableView.reloadData()
    }
    
    func loadItems(){
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)     ///decodable
//            } catch {
//                print("Error decoding item array, \(error)")
//            }
//        }
        
        
        
    }
    
}

