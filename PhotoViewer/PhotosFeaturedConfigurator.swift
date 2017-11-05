//
//  PhotosFeaturedConfigurator.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/05.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol PhotosFeaturedConfigurator {
    func configure(photosFeaturedViewController: PhotosFeaturedViewController)
}

class PhotosFeaturedConfiguratorImplementation: PhotosFeaturedConfigurator {
    func configure(photosFeaturedViewController: PhotosFeaturedViewController) {
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,
                                                completionHandlerQueue: OperationQueue.main)
        let apiPhotosGateway = ApiPhotosGatewayImplementation(apiClient: apiClient)
        let mlGateway = MLGatewayImplementation()
        
        let photosGateway = CachePhotosGateway(apiPhotosGateway: apiPhotosGateway, mlGateway: mlGateway)
        
        let fetchPhotosUseCase = GetPhotosUseCaseImplementation(photosGateway: photosGateway)
        let router = PhotosFeaturedViewRouterImplementation(photosFeaturedViewController: photosFeaturedViewController)
        
        let presenter = PhotosFeaturedPresenterImplementation(view: photosFeaturedViewController,
                                                              getPhotosUseCase: fetchPhotosUseCase,
                                                              router: router)
        
        photosFeaturedViewController.presenter = presenter
    }
}
