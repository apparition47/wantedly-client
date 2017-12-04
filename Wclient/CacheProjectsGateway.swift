//
//  CacheProjectsGateway.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

class CacheProjectsGateway: ProjectsGateway {
    let apiProjectsGateway: ApiProjectsGateway

    init(apiProjectsGateway: ApiProjectsGateway) {
        self.apiProjectsGateway = apiProjectsGateway
    }
    
    // MARK: - ProjectsGateway

    func search(parameters: SearchProjectsParameters, completionHandler: @escaping SearchProjectsEntityGatewayCompletionHandler) {
        apiProjectsGateway.search(parameters: parameters) { (result) in
            self.handleSearchProjectsApiResult(result, parameters: parameters, completionHandler: completionHandler)
        }
    }
    
    
    // MARK: - Private

    fileprivate func handleSearchProjectsApiResult(_ result: Result<[Project]>, parameters: SearchProjectsParameters, completionHandler: @escaping (Result<[Project]>) -> Void) {
        switch result {
        case .success(_):
            completionHandler(result)
        case .failure(_):
            completionHandler(result)
        }
    }
    
}
