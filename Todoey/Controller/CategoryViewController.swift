//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Vince Ng on 11/9/18.
//  Copyright © 2018 kindebean. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
    }
    
    
    // MARK: - TableView datasource. Initialize and populate the table.
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
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
                destinationVC.selectedCategory = categoryArray[indexPath.row]
            }
        }
    }
    
    
    // MARK: - Add new category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // Show alert
        let alert = UIAlertController(title: "New Category", message: nil, preferredStyle: .alert)
        var textField: UITextField!
        
        // Add action in alert
        let action = UIAlertAction(title: "Add Category", style: .default) {
            (alertAction) in
            
            // What to do when user completed the action?
            // Add new category to categoryArray, and save it to database
            let newCategory: Category = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            self.saveCategory()
        }
        
        // Add textField and action to alert
        alert.addTextField {
            (alertTextField) in
            
            alertTextField.placeholder = "Name your new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    
    // MARK: - Save and Load from database
    func saveCategory() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    func loadCategory() {
        
        // Make a request to fetch data to categoryArray
        let request: NSFetchRequest<Category> = Category.fetchRequest()
    
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context, \(error)")
        }
        
        tableView.reloadData()
    }
        
}







