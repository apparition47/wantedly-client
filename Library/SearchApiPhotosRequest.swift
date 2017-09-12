//
//  SearchApiPhotosRequest.swift
//  Library
//
//  Created by Aaron Lee on 2017/09/02.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import Foundation

struct SearchPhotosApiRequest: ApiRequest {
    let searchPhotosParameters: SearchPhotosParameters
    
    let path: String = "/search/photos"
    let httpMethod: String = "GET"
    var parameters: [String: Any]? {
        return searchPhotosParameters.toDictionary()
    }
    // TODO use Decodable for keypathing
//    var responseKeyPath: [String] = ["results"]
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
