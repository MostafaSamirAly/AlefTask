//
//  HomeTableViewCell.swift
//  AlefTask
//
//  Created by Mostafa Samir on 17/10/2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    var product: Product?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productImageView.layer.cornerRadius = 20
        productImageView.clipsToBounds = true
    }
    
    func configure(with product: Product) {
        self.product = product
        productImageView.setImage(with: product.images?.first?.imageName ?? "")
        productNameLabel.text = product.title
        productDescriptionLabel.text = product.productDescription
        checkFavourite()
    }
    
    private func checkFavourite() {
        if CoreDataHelper.shared.isFavourite(product) {
            product?.isFavourite = true
            favouriteButton.setImage(#imageLiteral(resourceName: "icon-favorite_24px"), for: .normal)
        }else {
            product?.isFavourite = false
            favouriteButton.setImage(#imageLiteral(resourceName: "icon-action-favorite_24px"), for: .normal)
        }
    }
    
    @IBAction func favouriteButtonTapped(_ sender: Any) {
        self.product?.isFavourite.toggle()
        if product?.isFavourite ?? false {
            favouriteButton.setImage(#imageLiteral(resourceName: "icon-favorite_24px"), for: .normal)
        }else {
            favouriteButton.setImage(#imageLiteral(resourceName: "icon-action-favorite_24px"), for: .normal)
        }
        CoreDataHelper.shared.toggleFavourite(for: product)
    }
    
}
