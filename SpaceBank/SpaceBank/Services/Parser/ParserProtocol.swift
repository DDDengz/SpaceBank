//
//  ParserProtocol.swift
//  SpaceBank
//
//  Created by Sam on 10.05.17.
//  Copyright © 2017 Semyon Vyatkin. All rights reserved.
//

import Foundation

enum ParserError: Error {
    case responseMalformed
}

protocol ParserProtocol {
    typealias JSONDictionary = [String: Any]
    typealias JSONArray = [JSONDictionary]
    
    init(_ json: JSONDictionary)
}
