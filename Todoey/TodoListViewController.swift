//
//  ViewController.swift
//  Todoey
//
//  Created by Vince Ng on 9/9/18.
//  Copyright © 2018 kindebean. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Post stuffs on carousell", "Re-stock groceries", "Learn Swift!"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        if let itemArray = defaults.array(forKey: "TodoListArray") as? [String] {
            self.itemArray = itemArray
        }
    }

    //MARK: - Tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK: - Tableview delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    
    @IBAction func addItemPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add New Item", style: .default) { (action) in
            
            // what happens after user add a new item
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

