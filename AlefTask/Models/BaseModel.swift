//
//  BaseModel.swift
//  AlefTask
//
//  Created by Mostafa Samir on 17/10/2021.
//

import Foundation

struct BaseModel<T: Codable>: Codable {
    var data: T?
}
