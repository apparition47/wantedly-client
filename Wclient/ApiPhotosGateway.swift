//
//  ApiPhotosGateway.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation


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
