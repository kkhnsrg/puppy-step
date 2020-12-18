//
//  NetworkConstants.swift
//  PuppyStep
//
//  Created by Sergey on 11/6/20.
//

import Foundation

struct Constants {
    
    //MARK: - URL
    static let baseUrl = "https://api.openweathermap.org"
    static let baseUrlSource = "https://openweathermap.org"
    
    //MARK: - Parameters
    struct Parameters {
        static let query = "q"
        static let appId = "appid"
        static let language = "lang"
    }
    
    //MARK: - Header
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    //MARK: - ContentType
    enum ContentType: String {
        case json = "application/json"
    }
    
    //MARK: - Errors
    enum ApiError: Error {
        case forbidden // 403
        case notFound // 404
        case conflict // 409
        case internalServerError // 500
    }
}
