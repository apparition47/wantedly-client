//
//  PhotoResultsConfigurator.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol PhotoResultsConfigurator {
    func configure(photoResultsViewController: PhotoResultsViewController)
}

class PhotoResultsConfiguratorImplementation: PhotoResultsConfigurator {
    let query: String
    
    init(query: String) {
        self.query = query
    }
    
    func configure(photoResultsViewController: PhotoResultsViewController) {
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,
                                                completionHandlerQueue: OperationQueue.main)
        let apiPhotosGateway = ApiPhotosGatewayImplementation(apiClient: apiClient)
        let mlGateway = MLGatewayImplementation()
        
        let photosGateway = CachePhotosGateway(apiPhotosGateway: apiPhotosGateway, mlGateway: mlGateway)
        
        let searchPhotosUseCase = SearchPhotosUseCaseImplementation(photosGateway: photosGateway)
        let router = PhotoResultsViewRouterImplementation(photoResultsViewController: photoResultsViewController)
        
        let presenter = PhotoResultsPresenterImplementation(view: photoResultsViewController,
                                                     searchPhotosUseCase: searchPhotosUseCase,
                                                     query: query,
                                                     router: router)
        
        photoResultsViewController.presenter = presenter
    }
}
