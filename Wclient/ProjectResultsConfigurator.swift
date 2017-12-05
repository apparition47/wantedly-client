//
//  ProjectResultsConfigurator.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol ProjectResultsConfigurator {
    func configure(projectResultsViewController: ProjectResultsViewController)
}

class ProjectResultsConfiguratorImplementation: ProjectResultsConfigurator {
    let query: String
    
    init(query: String) {
        self.query = query
    }
    
    func configure(projectResultsViewController: ProjectResultsViewController) {
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,
                                                completionHandlerQueue: OperationQueue.main)
        let apiProjectsGateway = ApiProjectsGatewayImplementation(apiClient: apiClient)

        
        let projectsGateway = CacheProjectsGateway(apiProjectsGateway: apiProjectsGateway)
        
        let searchProjectsUseCase = SearchProjectsUseCaseImplementation(projectsGateway: projectsGateway)
        let router = ProjectResultsViewRouterImplementation(projectResultsViewController: projectResultsViewController)
        
        let presenter = ProjectResultsPresenterImplementation(view: projectResultsViewController,
                                                     searchProjectsUseCase: searchProjectsUseCase,
                                                     query: query,
                                                     router: router)
        
        projectResultsViewController.presenter = presenter
    }
}
