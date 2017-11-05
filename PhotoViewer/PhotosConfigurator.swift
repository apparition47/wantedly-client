//
//  PhotosConfigurator.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol PhotosConfigurator {
    func configure(photosCollectionViewController: PhotosCollectionViewController)
}

class PhotosConfiguratorImplementation: PhotosConfigurator {
    
    func configure(photosCollectionViewController: PhotosCollectionViewController) {
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,
                                                completionHandlerQueue: OperationQueue.main)
        let apiPhotosGateway = ApiPhotosGatewayImplementation(apiClient: apiClient)
        let mlGateway = MLGatewayImplementation()
        
        let photosGateway = CachePhotosGateway(apiPhotosGateway: apiPhotosGateway, mlGateway: mlGateway)
        
        let searchPhotosUseCase = SearchPhotosUseCaseImplementation(photosGateway: photosGateway)
        let router = PhotosViewRouterImplementation(photosCollectionViewController: photosCollectionViewController)
        
        let presenter = PhotosPresenterImplementation(view: photosCollectionViewController,
                                                     searchPhotosUseCase: searchPhotosUseCase,
                                                     router: router)
        
        photosCollectionViewController.presenter = presenter
    }
}
