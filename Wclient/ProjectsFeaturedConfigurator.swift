//
//  ProjectsFeaturedConfigurator.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/05.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol ProjectsFeaturedConfigurator {
    func configure(ProjectsFeaturedViewController: ProjectsFeaturedViewController)
}

class ProjectsFeaturedConfiguratorImplementation: ProjectsFeaturedConfigurator {
    func configure(ProjectsFeaturedViewController: ProjectsFeaturedViewController) {
        let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,
                                                completionHandlerQueue: OperationQueue.main)
        let apiProjectsGateway = ApiProjectsGatewayImplementation(apiClient: apiClient)
        let mlGateway = MLGatewayImplementation()
        
        let ProjectsGateway = CacheProjectsGateway(apiProjectsGateway: apiProjectsGateway, mlGateway: mlGateway)
        
        let fetchProjectsUseCase = GetProjectsUseCaseImplementation(ProjectsGateway: ProjectsGateway)
        let router = ProjectsFeaturedViewRouterImplementation(ProjectsFeaturedViewController: ProjectsFeaturedViewController)
        
        let presenter = ProjectsFeaturedPresenterImplementation(view: ProjectsFeaturedViewController,
                                                              getProjectsUseCase: fetchProjectsUseCase,
                                                              router: router)
        
        ProjectsFeaturedViewController.presenter = presenter
    }
}
