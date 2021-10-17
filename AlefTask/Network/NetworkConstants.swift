//
//  NetworkConstants.swift
//  AlefTask
//
//  Created by Mostafa Samir on 17/10/21.
//


import Foundation
enum NetworkConstants {
    
    /// Base URLs
    static let baseURL = "https://productivefamiliesservices.alefsoftware.com/client/products/producttitle?lat=30.063903808594&lng=31.326583983165&page=1&title="
    
    /// The keys for HTTP header fields
    enum HTTPHeaderFieldKey: String {
        case authorization = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
        case string = "String"
    }
    
    /// The values for HTTP header fields
    enum HTTPHeaderFieldValue: String {
        case json = "application/json"
        case html = "text/html"
        case formEncode = "application/x-www-form-urlencoded"
        case accept = "*/*"
    }
}
