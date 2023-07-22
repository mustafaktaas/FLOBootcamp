//
//  CartTableViewCell.swift
//  AldinAldinShopping
//
//  Created by Mustafa Aktas on 5.07.2023.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
  
    var quantity = 1

    override func awakeFromNib() {
        super.awakeFromNib()
        quantity = 1
        
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func minusButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
    }
    
}
