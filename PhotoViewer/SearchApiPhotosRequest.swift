//
//  SearchApiPhotosRequest.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import Foundation
import Alamofire

struct SearchPhotosApiRequest: ApiRequest {
    typealias ResponseType = DecodableArray<Photo>

    let searchPhotosParameters: SearchPhotosParameters
    
    let path: String = "/search/photos"
    var parameters: [String: Any]? {
        return searchPhotosParameters.toDictionary()
    }
    static let responseKeyPath: [String] = ["results"]
}

extension SearchPhotosParameters {
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        dictionary["query"] = query
        
        if let page = page {
            dictionary["page"] = page
        }
        if let perPage = perPage {
            dictionary["per_page"] = perPage
        }
        
        if let collections = collections {
            dictionary["collections"] = collections
        }
        
        return dictionary
    }
}
