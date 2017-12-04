//
//  CachePhotosGateway.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

class CachePhotosGateway: PhotosGateway {
    let apiPhotosGateway: ApiPhotosGateway
    let mlGateway: MLGateway

    init(apiPhotosGateway: ApiPhotosGateway, mlGateway: MLGateway) {
        self.apiPhotosGateway = apiPhotosGateway
        self.mlGateway = mlGateway
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
    
    func detectDominant(parameters: DetectPhotoParameters, completionHandler: @escaping DetectPhotoEntityGatewayCompletionHandler) {
        
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
