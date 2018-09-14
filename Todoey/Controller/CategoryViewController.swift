//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Vince Ng on 11/9/18.
//  Copyright © 2018 kindebean. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
        
        tableView.rowHeight = 80.0
    }
    
    
    // MARK: - TableView datasource. Initialize and populate the table.
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No category added yet"
        cell.delegate = self
        
        return cell
    }
    

    
    
    // MARK: - TableView delegate. What to do when user do something to the table.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    // Prepare segue by passing over the selected category
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToItems" {
            
            let destinationVC = segue.destination as! TodoListViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories?[indexPath.row]
            }
        }
    }
    
    
    // MARK: - Add new category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // Show alert
        let alert = UIAlertController(title: "New Category", message: nil, preferredStyle: .alert)
        var textField: UITextField!
        
        // Add textField to alert
        alert.addTextField {
            (alertTextField) in
            
            alertTextField.placeholder = "Name your new category"
            textField = alertTextField
        }
        
        // Add action to alert
        let action = UIAlertAction(title: "Add Category", style: .default) {
            (alertAction) in
            
            // What to do when user completed the action?
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)    
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    
    // MARK: - Save and Load from database
    func save(category: Category) {
        
        do {
            try realm.write() {
                realm.add(category)
            }
        } catch {
            print("Error saving context, \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    func loadCategory() {

        categories = realm.objects(Category.self)
    }
    
}

//MARK: - Swipe cell delegate methods
extension CategoryViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") {
            (action, indexPath) in
            // handle action by updating model with deletion
            
//            if let selectedCategory = self.categories?[indexPath.row] {
//                do {
//                    try self.realm.write {
//                        self.realm.delete(selectedCategory)
//                    }
//                } catch {
//                    print("Error deleting category, \(error)")
//                }
//            }
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
}







