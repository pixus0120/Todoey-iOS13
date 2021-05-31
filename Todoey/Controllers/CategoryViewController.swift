//
//  CategoryViewController.swift
//  Todoey
//
//  Created by locussigilli on 5/25/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

///Child Class

import UIKit
import RealmSwift
///import SwipeCellKit

class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    var categoryArray : Results<Category>?
   // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
        tableView.rowHeight = 70.0
    }
    
    //MARK: - TableView Datasource Methods  1.
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray?.count ?? 1
    }
    
    //copy from cocoapods:
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "no categories added yet."

        return cell
     
    }
    
    //MARK: - TableView Delegate Metods 4.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCathegory = categoryArray?[indexPath.row]
        }
    }

    //MARK: - Data Manipulation Methods  2.
        
    func save(category: Category){       //save data to DB
       
        do {
                try realm.write{
                    realm.add(category)
                }
            } catch {
                print("Error saving category, \(error)")
            }
            self.tableView.reloadData()
        }
    
    func loadCategory() {
        
        categoryArray = realm.objects(Category.self)
//                let request: NSFetchRequest<Category> = Category.fetchRequest()
//                do {
//                    categoryArray = try context.fetch(request)
//                } catch {
//                    print("Error loading categories: \(error)")
//                }
            tableView.reloadData()
            }
    //MARK: - Delete Data From Swipe
    
    override func updateModel(at indexPath: IndexPath){
                    if let deletion = self.categoryArray?[indexPath.row] {
                    do {
                        try self.realm.write {
                        self.realm.delete(deletion)
                        }
                    } catch {
                        print("Error delete Item, \(error)")
                    }
                     //   tableView.reloadData()
                }
        
    }
    
    
    
    //MARK: - Add New Categories 3.
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

    var textField = UITextField()
        
    let alert = UIAlertController (title: "Add New Category", message: "", preferredStyle: .alert)
    let action = UIAlertAction (title: "Add", style: .default) { (action) in
        
        let newCategory = Category()
        newCategory.name = textField.text!
        
       // self.categoryArray.append(newCategory)
        self.save(category: newCategory)
      //  self.tableView.reloadData()
    }
    
        alert.addTextField { (alertTextField) in
        alertTextField.placeholder = "Create new Category"
        textField = alertTextField
    }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}


///       Moved to Swipe Table View Controller
//MARK: - Extension Swipe Table View Delegate Methods

//extension CategoryViewController:  SwipeTableViewCellDelegate {
//
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete")
//        { action, indexPath in
//            // handle action by updating model with deletion
//            print("Item Deleted")
//
//            if let deletion = self.categoryArray?[indexPath.row] {
//            do {
//                try self.realm.write {
//                self.realm.delete(deletion)
//                }
//            } catch {
//                print("Error delete Item, \(error)")
//            }
//             //   tableView.reloadData()
//        }
//        }
//        // customize the action appearance
//        deleteAction.image = UIImage(named: "delete-icon")
//
//        return [deleteAction]
//    }
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
//        options.transitionStyle = .border
//        return options
//    }
//}
//
//
