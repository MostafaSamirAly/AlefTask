//
//  RequestParamters.swift
//  AlefTask
//
//  Created by Mostafa Samir on 17/10/21.
//


import UIKit

protocol RequestParameters: Codable {
    func getParamsAsJson() -> [String: Any]
}

extension RequestParameters {
    func getParamsAsJson() -> [String: Any] {
        let jsonEncoder = JSONEncoder()

        guard let jsonData = try? jsonEncoder.encode(self) else {
            return [:]
        }
        guard let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        debugPrint(dictionary)
        return dictionary
    }
}
