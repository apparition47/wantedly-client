//
//  PhotosGateway.swift
//  Library
//
//  Created by Aaron Lee on 2017/09/02.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import Foundation

typealias FetchPhotosEntityGatewayCompletionHandler = (_ photos: Result<[Photo]>) -> Void
typealias SearchPhotosEntityGatewayCompletionHandler = (_ photos: Result<[Photo]>) -> Void

protocol PhotosGateway {
    func fetchPhotos(parameters: FetchPhotosParameters, completionHandler: @escaping FetchPhotosEntityGatewayCompletionHandler)
    func search(parameters: SearchPhotosParameters, completionHandler: @escaping SearchPhotosEntityGatewayCompletionHandler)
}
