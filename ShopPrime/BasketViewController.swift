//
//  BasketViewController.swift
//  ShopPrime
//
//  Created by Trakya11 on 8.07.2024.
//

import UIKit

class BasketViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var totalPriceArray: [Double] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var basketConfirmButton: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
            
        NotificationCenter.default.addObserver(self, selector: #selector(basketUpdated), name: NSNotification.Name("BasketUpdated"), object: nil)
    }
        
    @objc func basketUpdated() {
        updateTotalPrice()
        tableView.reloadData()
    }
    
    func updateTotalPrice() {
        let totalPrice = Basket.shared.totalPrice
        totalPriceLabel.text = String(format: "Sepet Tutarı: %.2f ₺", totalPrice)
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Basket.shared.productCount
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath)
        let product = Basket.shared.getProducts()[indexPath.row]
        var proPrice = product.price
        var proCount = Double(product.count)
        let totalPriceForProduct = proPrice * proCount
        cell.textLabel?.text = "\(product.name) - Adet: \(Int(proCount)) - Toplam Fiyat: \(totalPriceForProduct) ₺"
        totalPriceArray.append(totalPriceForProduct)
        updateTotalPrice()
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
    
            Basket.shared.getProducts()[indexPath.row]
            Basket.shared.removeProduct(at: indexPath.row)
            totalPriceArray.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .none)
            updateTotalPrice()
        }
    }
    
    
    
    @IBAction func basketConfirm(_ sender: UIButton) {
        Basket.shared.clearProducts()
        totalPriceLabel.text = "Sepet onaylandı"
        tableView.reloadData()
    }
    
}

