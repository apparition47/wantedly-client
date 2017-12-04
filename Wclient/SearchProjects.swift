//
//  SearchProjects.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/12/04.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

typealias SearchProjectsUseCaseCompletionHandler = (_ projects: Result<[Project]>) -> Void

struct SearchProjectsParameters {
    let query: String?
    let page: Int?
}

protocol SearchProjectsUseCase {
    func search(parameters: SearchProjectsParameters, completionHandler: @escaping SearchProjectsUseCaseCompletionHandler)
}

class SearchProjectsUseCaseImplementation: SearchProjectsUseCase {
    
    let projectsGateway: ProjectsGateway
    
    init(projectsGateway: ProjectsGateway) {
        self.projectsGateway = projectsGateway
    }
    
    // MARK: - SearchProjectsUseCase
    
    func search(parameters: SearchProjectsParameters, completionHandler: @escaping SearchProjectsUseCaseCompletionHandler) {
        self.projectsGateway.search(parameters: parameters) { result in
            completionHandler(result)
        }
    }
}
