//
//  PhotosGateway.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

typealias FetchPhotosEntityGatewayCompletionHandler = (_ photos: Result<[Photo]>) -> Void
typealias SearchPhotosEntityGatewayCompletionHandler = (_ photos: Result<[Photo]>) -> Void


protocol PhotosGateway {
    func fetchPhotos(parameters: FetchPhotosParameters, completionHandler: @escaping FetchPhotosEntityGatewayCompletionHandler)
    func search(parameters: SearchPhotosParameters, completionHandler: @escaping SearchPhotosEntityGatewayCompletionHandler)
}
