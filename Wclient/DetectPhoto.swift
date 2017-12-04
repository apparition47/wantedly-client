//
//  DetectPhoto.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

typealias DetectPhotoUseCaseCompletionHandler = (_ content: Result<String>) -> Void

protocol DetectPhotoUseCase {
    func detectDominant(parameters: DetectPhotoParameters, completionHandler: @escaping DetectPhotoEntityGatewayCompletionHandler)
}

struct DetectPhotoParameters {
    let photoUrl: String?
}

class DetectPhotoUseCaseImplementation: DetectPhotoUseCase {
    let mlGateway: MLGateway
    
    init(mlGateway: MLGateway) {
        self.mlGateway = mlGateway
    }
    
    // MARK: - DetectPhotoUseCase
    
    func detectDominant(parameters: DetectPhotoParameters, completionHandler: @escaping DetectPhotoEntityGatewayCompletionHandler) {
        self.mlGateway.detectDominant(parameters: parameters) { result in
            completionHandler(result)
        }
    }
}
