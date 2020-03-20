//
//  RequestRouter.swift
//  Translater
//
//  Created by Booharin on 19.03.2020.
//  Copyright © 2020 Umbrella. All rights reserved.
//

import Alamofire

public protocol RequestRouter: URLRequestConvertible {
    var baseUrl: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters { get }
    var fullUrl: URL { get }
}

public extension RequestRouter {
    var fullUrl: URL {
        return baseUrl.appendingPathComponent(path)
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = [
            "Accept" : "application/json"
        ]
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }

}
