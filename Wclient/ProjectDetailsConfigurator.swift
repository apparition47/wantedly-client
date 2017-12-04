//
//  ProjectDetailsConfigurator.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//


import Foundation

protocol ProjectDetailsConfigurator {
	func configure(ProjectDetailsTableViewController: ProjectDetailsTableViewController)
}

class ProjectDetailsConfiguratorImplementation: ProjectDetailsConfigurator {
	let Project: Project
	
	init(Project: Project) {
		self.Project = Project
	}
	
	func configure(ProjectDetailsTableViewController: ProjectDetailsTableViewController) {
		let router = ProjectDetailsViewRouterImplementation(ProjectDetailsTableViewController: ProjectDetailsTableViewController)
		
        let mlGateway = MLGatewayImplementation()
        let detectProjectUseCase = DetectProjectUseCaseImplementation(mlGateway: mlGateway)
        
        let presenter = ProjectDetailsPresenterImplementation(view: ProjectDetailsTableViewController,
                                                            detectProjectUseCase: detectProjectUseCase,
		                                     Project: Project,
		                                     router: router)

		ProjectDetailsTableViewController.presenter = presenter
	}
}
