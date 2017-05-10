//
//  PointsViewModel.swift
//  SpaceBank
//
//  Created by Sam on 10.05.17.
//  Copyright © 2017 Semyon Vyatkin. All rights reserved.
//

import Foundation
import UIKit

class PointsViewModel {
    typealias CompletionBlock = (Void) -> Void
    typealias ExceptionBlock = (Error?) -> Void
    
    private var _points = [Point]()
    
    var points: [Point] { return _points }
    
    // MARK: - Methods
    func fetch(_ completion: CompletionBlock? = nil, exception: ExceptionBlock? = nil) {
        let netRequest = API.points.request
        let netService = NetworkService(for: SessionManager.shared.session)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        netService.execute(netRequest, completion: { [weak weakSelf = self] (data) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            guard let strongSelf = weakSelf else {
                completion?()
                return
            }
            
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? ParserProtocol.JSONDictionary else {
                DispatchQueue.main.async {
                    exception?(ParserError.responseMalformed)
                }
                
                return
            }
            
            guard let points = jsonData?["items"] as? ParserProtocol.JSONArray else {
                DispatchQueue.main.async {
                    exception?(ParserError.responseMalformed)
                }
                
                return
            }
                                    
            strongSelf._points = points.flatMap { Point($0) }
            DispatchQueue.main.async { completion?() }
        })
        { (error) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            exception?(error)
        }
    }
}
