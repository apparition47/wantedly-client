//
//  SearchApiProjectsRequest.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation
import Alamofire

struct SearchProjectsApiRequest: ApiRequest {
    typealias ResponseType = DecodableArray<Project>

    let searchProjectsParameters: SearchProjectsParameters
    
    let path = "/projects"
    var parameters: [String: Any]? {
        return searchProjectsParameters.toDictionary()
    }
    static let responseKeyPath: [String] = ["data"]
}

extension SearchProjectsParameters {
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        
        if let page = page {
            dictionary["page"] = page
        }
        
        if let query = query {
            dictionary["q"] = query
        }
        
        return dictionary
    }
}
