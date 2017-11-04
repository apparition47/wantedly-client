//
//  DetectPhoto.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import Foundation

typealias DetectPhotoUseCaseCompletionHandler = (_ content: Result<String>) -> Void

protocol DetectPhotoUseCase {
    func detectDominant(parameters: DetectPhotoParameters, completionHandler: @escaping DetectPhotoEntityGatewayCompletionHandler)
}

// This class is used across all layers - Core, UI and Network
// It's not violating any dependency rules.
// However it might make sense for each layer do define it's own input parameters so it can be used independently of the other layers.
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
            // Do any additional processing & after that call the completion handler
            completionHandler(result)
        }
    }
}
