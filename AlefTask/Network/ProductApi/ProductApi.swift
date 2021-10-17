//
//  ProductApi.swift
//  AlefTask
//
//  Created by Mostafa Samir on 17/10/2021.
//

import Foundation

enum ProductApi: Requestable {
    case getProducts(String)
    
    var path: String {
        switch self {
        case .getProducts(let title):
            return title
        }
    }
}
