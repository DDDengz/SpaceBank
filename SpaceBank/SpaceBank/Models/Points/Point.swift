//
//  Point.swift
//  SpaceBank
//
//  Created by Sam on 10.05.17.
//  Copyright © 2017 Semyon Vyatkin. All rights reserved.
//

import Foundation

struct Point {
    struct Location {
        var latitude = 0.0
        var longitude = 0.0        
    }
    
    var id: String
    var name: String
    var address: String
    var schedule: String?
    var location: Point.Location
}

extension Point: ParserProtocol {
    
    init(_ json: JSONDictionary) {    
        id = json["id"] as! String
        name = json["title"] as! String
        address = json["address"] as! String
        schedule = json["schedule"] as? String
        location = Point.Location()
        
        if let jsonLocation = json["location"] as? JSONDictionary,
            let lat = jsonLocation["lat"] as? NSNumber,
            let lng = jsonLocation["lng"] as? NSNumber {
        
            location.latitude = lat.doubleValue
            location.longitude = lng.doubleValue
        }
    }
}
