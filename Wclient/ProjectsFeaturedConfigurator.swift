//
//  ProjectsFeaturedConfigurator.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/05.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol ProjectsFeaturedConfigurator {
    func configure(projectsFeaturedViewController: ProjectsFeaturedViewController)
}

class ProjectsFeaturedConfiguratorImplementation: ProjectsFeaturedConfigurator {
    func configure(projectsFeaturedViewController: ProjectsFeaturedViewController) {
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,
                                                completionHandlerQueue: OperationQueue.main)
        let apiProjectsGateway = ApiProjectsGatewayImplementation(apiClient: apiClient)
        
        let ProjectsGateway = CacheProjectsGateway(apiProjectsGateway: apiProjectsGateway)
        
        let fetchProjectsUseCase = SearchProjectsUseCaseImplementation(projectsGateway: ProjectsGateway)
        let router = ProjectsFeaturedViewRouterImplementation(projectsFeaturedViewController: projectsFeaturedViewController)
        
        let presenter = ProjectsFeaturedPresenterImplementation(view: projectsFeaturedViewController,
                                                              getProjectsUseCase: fetchProjectsUseCase,
                                                              router: router)
        
        projectsFeaturedViewController.presenter = presenter
    }
}
