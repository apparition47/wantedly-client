//
//  ApiProjectsGateway.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation


protocol ApiProjectsGateway: ProjectsGateway {
    
}

class ApiProjectsGatewayImplementation: ApiProjectsGateway {
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - ApiProjectsGateway
    
    func search(parameters: SearchProjectsParameters, completionHandler: @escaping SearchProjectsEntityGatewayCompletionHandler) {
        let ProjectsApiRequest = SearchProjectsApiRequest(SearchProjectsParameters: parameters)
        apiClient.execute(ProjectsApiRequest) { (result: Result<SearchProjectsApiRequest.ResponseType>) in
            switch result {
            case let .success(response):
                completionHandler(.success(response.array))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
