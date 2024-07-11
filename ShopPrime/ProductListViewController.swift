//
//  ProductListViewController.swift
//  ShopPrime
//
//  Created by Trakya11 on 8.07.2024.
//

import UIKit

struct Product {
    let name: String
    let description: String
    let price: Double
    var count: Int
}

class ProductListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var products = [
        Product(name: "Batuhan Karasu", description: "Description 1", price: 1191602005, count: 100),
        Product(name: "Z", description: "Description 1", price: 444, count: 100),
        Product(name: "Product 1", description: "Description 1", price: 7777, count: 100),
        Product(name: "Product 2", description: "Description 2", price: 7777, count: 100),
        Product(name: "Product 3", description: "Description 3", price: 7777, count: 100)
        ]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.dataSource = self
            tableView.delegate = self
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return products.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
            let product = products[indexPath.row]
            cell.textLabel?.text = "\(product.name) - \(product.price) $"
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedProduct = products[indexPath.row]
            performSegue(withIdentifier: "showDetail", sender: selectedProduct)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showDetail" {
                if let destinationVC = segue.destination as? ProductDetailViewController, let product = sender as? Product {
                    destinationVC.product = product
                }
            }
        }
}

