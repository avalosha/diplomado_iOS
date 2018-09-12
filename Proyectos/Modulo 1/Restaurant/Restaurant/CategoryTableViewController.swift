//
//  CategoryTableTableViewController.swift
//  Restaurant
//
//  Created by Álvaro Ávalos Hernández on 07/09/18.
//  Copyright © 2018 Álvaro Ávalos Hernández. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    //let menuController = MenuController()
    var categories = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        MenuController.shared.fetchCategories { (categories) in
            if let categories = categories {
                self.updateUI(with: categories)
            }
        }
    }
    
    func updateUI(with categories: [String]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuSegue" {
            let menuTableViewController = segue.destination as! MenuTableViewController
            let index = tableView.indexPathForSelectedRow!.row
            menuTableViewController.category = categories[index]
        }
    }
    
    //the methods that define how many rows the table view will have and create a cell for each row to be displayed.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    //“The number of rows (and cells) is equal to the number of items in the categories property, and the text of each cell will display a string.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "CategoryCellIdentifier", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }

    func configure(cell: UITableViewCell, forItemAt indexPath:
        IndexPath) {
        let categoryString = categories[indexPath.row]
        cell.textLabel?.text = categoryString.capitalized
    }

}
