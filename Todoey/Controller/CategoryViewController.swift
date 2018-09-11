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

        // TODO: - Load categories
        loadCategory()
        
    }


    // MARK: - TableView datasource methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
    }
    
    
    // MARK: - TableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    // MARK: - Add New Category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "New Category", message: nil, preferredStyle: .alert)
        
        alert.addTextField {
            (alertTextField) in
            
            alertTextField.placeholder = "Name your new category"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add new category", style: .default) {
            (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            self.saveCategory()
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Data Manipulation methods
    
    func loadCategory() {
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context, \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func saveCategory() {
        
        do {
            try context.save()
        } catch {
            print("Error saving data to context, \(error)")
        }
        
        tableView.reloadData()
    }
    
    
}







