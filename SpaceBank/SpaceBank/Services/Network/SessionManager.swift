//
//  SessionManager.swift
//  SpaceBank
//
//  Created by Sam on 10.05.17.
//  Copyright © 2017 Semyon Vyatkin. All rights reserved.
//

import Foundation

class SessionManager {
    struct Consts {
        static let timeoutIntervalForRequest = 30.0
        static let timeoutIntervalForResource = 300.0
    }
    
    static let shared = SessionManager()
    
    private var _session: URLSession
    private var _configuration: URLSessionConfiguration
    private var _httpHeaders = [
        "Accept": "application/json",
        "Accept-Encoding": "gzip, deflate",
        "Content-Type": "application/json;charset=utf-8",
        "Content-Encoding": "gzip"
    ]    
    
    var session: URLSession { return _session }
    var configuration: URLSessionConfiguration { return _configuration }
    var httpHeaders: [String: String] { return _httpHeaders }
    
    // MARK: - LifeCycle
    init() {
        _configuration = URLSessionConfiguration.default
        _configuration.allowsCellularAccess = true
        _configuration.httpCookieAcceptPolicy = .never
        _configuration.timeoutIntervalForRequest = Consts.timeoutIntervalForRequest
        _configuration.timeoutIntervalForResource = Consts.timeoutIntervalForResource
        
        _session = URLSession(configuration: _configuration)
    }
}
