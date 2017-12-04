//
//  ProjectResultsConfigurator.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol ProjectResultsConfigurator {
    func configure(ProjectResultsViewController: ProjectResultsViewController)
}

class ProjectResultsConfiguratorImplementation: ProjectResultsConfigurator {
    let query: String
    
    init(query: String) {
        self.query = query
    }
    
    func configure(ProjectResultsViewController: ProjectResultsViewController) {
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,
                                                completionHandlerQueue: OperationQueue.main)
        let apiProjectsGateway = ApiProjectsGatewayImplementation(apiClient: apiClient)

        
        let ProjectsGateway = CacheProjectsGateway(apiProjectsGateway: apiProjectsGateway, mlGateway: mlGateway)
        
        let searchProjectsUseCase = SearchProjectsUseCaseImplementation(ProjectsGateway: ProjectsGateway)
        let router = ProjectResultsViewRouterImplementation(ProjectResultsViewController: ProjectResultsViewController)
        
        let presenter = ProjectResultsPresenterImplementation(view: ProjectResultsViewController,
                                                     searchProjectsUseCase: searchProjectsUseCase,
                                                     query: query,
                                                     router: router)
        
        ProjectResultsViewController.presenter = presenter
    }
}
