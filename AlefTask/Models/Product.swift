//
//  Product.swift
//  AlefTask
//
//  Created by Mostafa Samir on 17/10/2021.
//


import Foundation

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title, productDescription: String?
    let images: [Image]?
    var isFavourite: Bool = false
    
    init(id: Int?, title:String?, productDescription:String?, image:String?) {
        self.id = id
        self.title = title
        self.productDescription = productDescription
        self.images = [Image(imageName: image)]
    }

    enum CodingKeys: String, CodingKey {
        case id, title
        case productDescription = "description"
        case images
    }
}

// MARK: - Image
struct Image: Codable {
    let imageName: String?

    enum CodingKeys: String, CodingKey {
        case imageName = "image_name"
    }
}
