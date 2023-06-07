//
//  DeliveryCell.swift
//  domashka1Ram
//
//  Created by Erzhan Tokochev on 5/26/23.
//

import UIKit

class DeliveryCell: UICollectionViewCell {

    static let reuseID = String(
        describing: DeliveryCell.self)
    static let nibname = String(
        describing: DeliveryCell.self)

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var title: UILabel!

    override func layoutSubviews() {
        titleImage.image = UIImage(
            systemName: "person.fill")
        title.text = "Delivery"
        title.textColor = .white
        
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .orange
    }

}
