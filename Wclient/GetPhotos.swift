//
//  GetPhotos.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

typealias GetPhotosUseCaseCompletionHandler = (_ photos: Result<[Photo]>) -> Void

protocol GetPhotosUseCase {
    func fetchPhotos(parameters: FetchPhotosParameters, completionHandler: @escaping GetPhotosUseCaseCompletionHandler)
}

struct FetchPhotosParameters {
    let page: Int?
    let perPage: Int?
    let orderBy: OrderBy?
}

enum OrderBy: String {
    case Latest = "latest"
    case Oldest = "oldest"
    case Popular = "popular"
}

class GetPhotosUseCaseImplementation: GetPhotosUseCase {

    let photosGateway: PhotosGateway
    
    init(photosGateway: PhotosGateway) {
        self.photosGateway = photosGateway
    }
    
    // MARK: - GetPhotosUseCase
    
    func fetchPhotos(parameters: FetchPhotosParameters, completionHandler: @escaping GetPhotosUseCaseCompletionHandler) {
        self.photosGateway.fetchPhotos(parameters: parameters) { (result) in
            // Do any additional processing & after that call the completion handler
            completionHandler(result)
        }
    }
}
