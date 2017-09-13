//
//  ApiBooksGateway.swift
//  Library
//
//  Created by Aaron Lee on 2017/09/02.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import Foundation

// This protocol in not necessarily needed since it doesn't include any extra methods
// besides what BooksGateway already provides. However, if there would be any extra methods
// on the API that we would need to support it would make sense to have an API specific gateway protocol
protocol ApiPhotosGateway: PhotosGateway {
    
}

class ApiPhotosGatewayImplementation: ApiPhotosGateway {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - ApiPhotosGateway
    
    func fetchPhotos(parameters: FetchPhotosParameters, completionHandler: @escaping FetchPhotosEntityGatewayCompletionHandler) {
        let photosApiRequest = GetPhotosApiRequest(fetchPhotosParameters: parameters)
        apiClient.execute(photosApiRequest) { result in
            
            switch result {
            case .success(let response):
                completionHandler(.success(response.array))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func search(parameters: SearchPhotosParameters, completionHandler: @escaping SearchPhotosEntityGatewayCompletionHandler) {
        let photosApiRequest = SearchPhotosApiRequest(searchPhotosParameters: parameters)
        apiClient.execute(photosApiRequest) { (result: Result<SearchPhotosApiRequest.ResponseType>) in
            switch result {
            case let .success(response):
                completionHandler(.success(response.array))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
