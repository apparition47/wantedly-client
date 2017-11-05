//
//  MLGateway.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit
import CoreML
import Vision

typealias DetectPhotoEntityGatewayCompletionHandler = (_ photos: Result<String>) -> Void

protocol MLGateway {
    func detectDominant(parameters: DetectPhotoParameters, completionHandler: @escaping DetectPhotoEntityGatewayCompletionHandler)
}

class MLGatewayImplementation: MLGateway {    
    let inceptionModel: VNCoreMLModel
    
    init() {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("can't load Places ML model")
        }
        
        self.inceptionModel = model
    }
    
    // MARK: - MLGateway

    func detectDominant(parameters: DetectPhotoParameters, completionHandler: @escaping (Result<String>) -> Void) {
        
        URLSession.shared.dataTask(with: URL(string: parameters.photoUrl!)!, completionHandler: { (data, response, error) in
            if error != nil {
                completionHandler(.failure(error!))
                return
            }
            
            if let image = UIImage(data: data!) {
                self.runModel(image: image) { result in
                    completionHandler(result)
                }
            }
            
        }).resume()
    }
    
    // MARK: - private
    
    private func runModel(image: UIImage, completionHandler: @escaping (Result<String>) -> Void) {
        guard let ciImage = image.cgImage else {
            return
        }
        
        let request = VNCoreMLRequest(model: inceptionModel) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first else {
                    fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            completionHandler(.success(topResult.identifier))
        }
        
        let handler = VNImageRequestHandler(cgImage: ciImage)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
                completionHandler(.failure(error))
            }
        }
    }
}
