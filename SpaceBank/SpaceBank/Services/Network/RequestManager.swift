//
//  RequestManager.swift
//  SpaceBank
//
//  Created by Sam on 10.05.17.
//  Copyright © 2017 Semyon Vyatkin. All rights reserved.
//

import Foundation

// MARK: - API
enum API {
    case points
}

extension API: URLResourceProtocol {
    
    var base: String {
        return "http://gymn652.ru/"
    }
    
    var path: String {
        return "tmp/unicorn.txt-2.json"
    }
}

// MARK: - Request Method
enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

// MARK: - URLResource Protocol
protocol URLResourceProtocol {
    var base: String { get }
    var method: RequestMethod { get }
    var path: String { get }
}

extension URLResourceProtocol {
    
    var method: RequestMethod {
        return .get
    }
    
    var request: URLRequest {
        guard let url = URL(string: base) else {
            fatalError("Can't create base URL from \(base)")
        }
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.allowsCellularAccess = SessionManager.shared.configuration.allowsCellularAccess
        request.allHTTPHeaderFields = SessionManager.shared.httpHeaders
        request.cachePolicy = SessionManager.shared.configuration.requestCachePolicy
        request.timeoutInterval = SessionManager.shared.configuration.timeoutIntervalForRequest
     
        return request
    }
}
