//
//  NetworkService.swift
//  SpaceBank
//
//  Created by Sam on 10.05.17.
//  Copyright © 2017 Semyon Vyatkin. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case responseMalformed
    case responseStatusCode(code: Int)
    case unknownError(Error)
}

class NetworkService {
    typealias CompletionBlock = (Data) -> Void
    typealias ExceptionBlock = (Error?) -> Void
    
    private let session: URLSession
    
    // MARK: - LifeCycle
    init(for session: URLSession) {
        self.session = session
    }
    
    // MARK: - Methods
    func execute(_ request: URLRequest, completion: CompletionBlock? = nil, exception: ExceptionBlock? = nil) {
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                exception?(error)
                return
            }
         
            guard let httpResponse = response as? HTTPURLResponse else {
                exception?(NetworkError.responseMalformed)
                return
            }
            
            if 200 ..< 300 ~= httpResponse.statusCode {
                completion?(data ?? Data())
            }
            else {
                exception?(NetworkError.responseStatusCode(code: httpResponse.statusCode))
            }
        }
        
        task.resume()
    }
}
