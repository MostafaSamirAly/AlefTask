//
//  MyError.swift
//  AlefTask
//
//  Created by Mostafa Samir on 17/10/21.
//

import Foundation

enum MyError: Error {
    // MARK: - Internal errors
    case noInternet
    // MARK: - API errors
    case badAPIRequest
    // MARK: - Auth errors
    case unauthorized
    // MARK: - Unknown errors
    case unknown
    case serverError
    case timeout
    
}

extension MyError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No Internet Connection"
        case .badAPIRequest:
            return "Bad Api Request"
        case .unauthorized:
            return "UnAuthorized"
        case .unknown:
            return "Something Went Wrong"
        case .serverError:
            return "Internal Server Error"
        case .timeout:
            return "Connection Timed Out"
        }
    }
}
