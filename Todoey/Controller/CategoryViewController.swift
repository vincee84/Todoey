//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Vince Ng on 11/9/18.
//  Copyright © 2018 kindebean. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.separatorStyle = .none
        loadCategory()
    }
    
    
    // MARK: - TableView datasource. Initialize and populate the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.backgroundColor = UIColor.randomFlat
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No category added yet"
        
        return cell
    }

    
    // MARK: - TableView delegate. What to do when user do something to the table.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
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
        
        let alert = UIAlertController(title: "New Category", message: nil, preferredStyle: .alert)
        var textField: UITextField!
        
        alert.addTextField {
            (alertTextField) in
            
            alertTextField.placeholder = "Name your new category"
            textField = alertTextField
        }
        
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
    
    
    // MARK: - CRUD from database
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
    
    // Delete from database
    override func updateModel(at indexPath: IndexPath) {
        super.updateModel(at: indexPath)
        
        if let selectedCategory = categories?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(selectedCategory)
                }
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }
    
}


