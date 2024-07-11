//
//  ProductDetailViewController.swift
//  ShopPrime
//
//  Created by Trakya11 on 8.07.2024.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productimage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productCount: UILabel!
    
    
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let product = product {
            productNameLabel.text = product.name
            productDescriptionLabel.text = product.description
            productPrice.text = String(format: "%.2f", product.price)
            
        }
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        
        print("Button pressed")
        guard var product = product else { return }
                
        if let count = Int(productCount.text ?? "0") {
            product.count = count
            Basket.shared.addProduct(product)
            navigationController?.popViewController(animated: true)
            print("Ürün eklendi: \(product.name), Toplam Fiyat: \(product.price * Double(product.count))")
        } else {
            print("Hata: Ürün sayısı alınamadı.")
        }
    }
    
    
    @IBAction func productCountUp(_ sender: UIButton) {
        if var count = Int(productCount.text ?? "0"){
            if 0 <= count && count < 15 {
                count += 1
                productCount.text = "\(count)"
            }
        } else {
            print(" + Arttırmada hata var")
        }
    }

    @IBAction func productCountDown(_ sender: UIButton) {
        if var count = Int(productCount.text ?? "0") {
            if count > 0 {
                count -= 1
                productCount.text = "\(count)"
            }
        } else {
            print(" - Azalmada hata var")
        }
    }

}
