//
//  CategoryCollectionViewCell.swift
//  AldinAldinShopping
//
//  Created by Mustafa Aktas on 29.06.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 15
        layer.masksToBounds = true
    }

}
