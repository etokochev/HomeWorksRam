//
//  ProductTableViewCell.swift
//  domashka1Ram
//
//  Created by Erzhan Tokochev on 5/26/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    static let reuseId = String(
        describing:
            ProductTableViewCell.self)
    
    static let nibName = String(
        describing:
            ProductTableViewCell.self)
    
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    func display(item: Product) {
        productName.text = item.title
        ratingLabel.text = String(item.rating)
        productDescription.text = item.description
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let data = ImageDownloader(
                urlString: item.thumbnail
            ).donwload()
            else {
                return
            }
            DispatchQueue.main.async {
                self.productImage.image = UIImage(data: data)
            }
        }
    }
    
    
    
    
    
    
    
}


