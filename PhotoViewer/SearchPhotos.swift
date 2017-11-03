//
//  SearchPhotos.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import Foundation

typealias SearchBookUseCaseCompletionHandler = (_ books: Result<[Photo]>) -> Void

struct SearchPhotosParameters {
    let query: String
    let page: Int?
    let perPage: Int?
    let collections: [Int]?
}

protocol SearchPhotosUseCase {
    func search(parameters: SearchPhotosParameters, completionHandler: @escaping SearchBookUseCaseCompletionHandler)
}

class SearchPhotosUseCaseImplementation: SearchPhotosUseCase {
    
    let photosGateway: PhotosGateway
    
    init(photosGateway: PhotosGateway) {
        self.photosGateway = photosGateway
    }
    
    // MARK: - SearchPhotosUseCase
    
    func search(parameters: SearchPhotosParameters, completionHandler: @escaping SearchBookUseCaseCompletionHandler) {
        self.photosGateway.search(parameters: parameters) { (result) in
            completionHandler(result)
        }
    }
}
