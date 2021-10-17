//
//  UIImage+Ext.swift
//  ExhibitSmart
//
//  Created by Mostafa Samir on 12/10/20.
//  Copyright © 2020 Mostafa Samir. All rights reserved.
//

import SDWebImage

extension UIImageView {
    func setImage(with url: String) {
        self.sd_cancelCurrentImageLoad()
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: url), placeholderImage: nil, options: [.scaleDownLargeImages, .retryFailed], context: [:])
    }
}
