//
//  Basket.swift
//  ShopPrime
//
//  Created by Trakya11 on 8.07.2024.
//

import Foundation

class Basket {
    static let shared = Basket()
    private init() {}
    
    private var products: [Product] = []
    
    var productCount: Int {
        return products.count
    }
    
    var totalPrice: Double {
        return products.reduce(0.0) { $0 + ($1.price * Double($1.count)) }
    }
    
    func addProduct(_ product: Product) {
        products.append(product)
        print(product)
        NotificationCenter.default.post(name: NSNotification.Name("BasketUpdated"), object: nil)

    }

    func removeProduct(at index: Int) {
            guard index < products.count else { return }
            products.remove(at: index)
            NotificationCenter.default.post(name: NSNotification.Name("BasketUpdated"), object: nil)
        }
    
    
    func getProducts() -> [Product] {
        return products
    }
    
    func clearProducts() {
        products.removeAll()
        NotificationCenter.default.post(name: NSNotification.Name("BasketUpdated"), object: nil)
    }
    
}

