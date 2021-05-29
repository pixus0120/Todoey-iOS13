//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    let realm = try! Realm()
    var toDoItems: Results<Item>? //  let defaults = UserDefaults.standard  //storage local singelton
    var selectedCathegory  : Category? {
        didSet {
            loadItems()
        }
    }
    
 //   let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)  //.first?.appendingPathComponent("Items.plist")
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //    searchBar.delegate = self
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//        let newItem = Item()
//        newItem.title = "Find mike"
//        itemArray.append(newItem)

    //     let request : NSFetchRequest<Item> = Item.fetchRequest()
        //      loadItems()
        //load saved array data
  //      if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
  //          itemArray = items
  //      }
    }
   //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = toDoItems?[indexPath.row] {
        cell.textLabel?.text = item.title
        
        //ternary operator ==>
        // value = condition ? valueIfTRUE : valueIfFALSE
        cell.accessoryType = item.done ? .checkmark : .none    ////
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
    /*    if item.done == true {   ///
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none             ///
        }    */
        return cell
    }
    
    //MARK: - Table View Delegate Mathods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row] {
        do {
            try realm.write {
                item.done = !item.done     //eq oposete
            }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        tableView.reloadData()
       // print(itemArray[indexPath.row])
      //  itemArray[indexPath.row].done
    //    context.delete(itemArray[indexPath.row])    //delete temporary w/o save
    //    itemArray.remove(at: indexPath.row)      //delete data from DB
        
//        itemArray[indexPath.row].done = !itemArray[indexPath.row].done  /// oposite !!!

 //       saveItems()
        
  //      tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDoList Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happend once the user clicks the Add Item button on our UIAlert
            
        //    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            if let currentCategory = self.selectedCathegory {
                do {
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
            present(alert, animated: true, completion: nil)
    }

//MARK: - Model Manipulation Methods
    
//    func saveItems(){       //save data to DB
//
//        do {
//            try context.save()
//        } catch {
//            print("Error saving content, \(error)")
//        }
//        self.tableView.reloadData()
//    }
    
    func loadItems(){     // load, read data from DB
        toDoItems = selectedCathegory?.items.sorted(byKeyPath: "title", ascending: true)
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)     ///decodable
//            } catch {
//                print("Error decoding item array, \(error)")
//            }
//        }
//        let categoryPredicate = NSPredicate(format: "parentCategory.name Matches %@", selectedCathegory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
 //       let compaundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
 //       request.predicate = compaundPredicate

//
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Erorr ferching context data: \(error)")
//        }
        tableView.reloadData()
    }
}
//MARK: - Search bar methods
//
//extension ToDoListViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate (format: "title CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
//        if searchBar.text?.count == 0 {   //
//            loadItems()
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//
//        }
//    }
//}
