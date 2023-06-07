//
//  CategoryCell.swift
//  domashka1Ram
//
//  Created by Erzhan Tokochev on 5/26/23.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static let reuseID = String(
        describing: CategoryCell.self)
    static let nibname = String(
        describing: CategoryCell.self)

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!

    func display(item: Category) {
        productImage.image = UIImage(
            named: item.CategoryProductImage)
        productTitle.text = item.CategoryProductName
    }
}
