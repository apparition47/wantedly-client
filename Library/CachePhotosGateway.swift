//
//  CachePhotosGateway.swift
//  Library
//
//  Created by Aaron Lee on 2017/09/03.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import Foundation

// Discussion:
// Maybe it makes sense to perform all the operations locally and only after that make the API call
// to sync the local content with the API.
// If that's the case you will only have to change this class and the use case won't be impacted
class CachePhotosGateway: PhotosGateway {
    let apiPhotosGateway: ApiPhotosGateway

    init(apiPhotosGateway: ApiPhotosGateway) {
        self.apiPhotosGateway = apiPhotosGateway
    }
    
    // MARK: - PhotosGateway
    
    func fetchPhotos(parameters: FetchPhotosParameters, completionHandler: @escaping FetchPhotosEntityGatewayCompletionHandler) {
        apiPhotosGateway.fetchPhotos(parameters: parameters) { (result) in
            self.handleFetchPhotoApiResult(result, parameters: parameters, completionHandler: completionHandler)
        }
    }
    
    func search(parameters: SearchPhotosParameters, completionHandler: @escaping SearchPhotosEntityGatewayCompletionHandler) {
        apiPhotosGateway.search(parameters: parameters) { (result) in
            self.handleSearchPhotosApiResult(result, parameters: parameters, completionHandler: completionHandler)
        }
    }
    
    // MARK: - Private
    
    fileprivate func handleFetchPhotoApiResult(_ result: Result<[Photo]>, parameters: FetchPhotosParameters, completionHandler: @escaping (Result<[Photo]>) -> Void) {
        switch result {
        case .success(_):
            completionHandler(result)
        case .failure(_):
            completionHandler(result)
        }
    }
    
    fileprivate func handleSearchPhotosApiResult(_ result: Result<[Photo]>, parameters: SearchPhotosParameters, completionHandler: @escaping (Result<[Photo]>) -> Void) {
        switch result {
        case .success(_):
            completionHandler(result)
        case .failure(_):
            completionHandler(result)
        }
    }
    
}
