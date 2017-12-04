//
//  GetPhotosApiRequest.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

struct GetPhotosApiRequest: ApiRequest {
    let fetchPhotosParameters: FetchPhotosParameters
    
    let path: String = "/photos"
    var parameters: [String: Any]? {
        return fetchPhotosParameters.toDictionary()
    }
    typealias ResponseType = DecodableArray<Photo>
}

extension FetchPhotosParameters {
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        if let page = page {
            dictionary["page"] = page
        }
        if let perPage = perPage {
            dictionary["per_page"] = perPage
        }
        
        if let orderBy = orderBy {
            dictionary["order_by"] = orderBy.rawValue
        }
        
        return dictionary
    }
}
