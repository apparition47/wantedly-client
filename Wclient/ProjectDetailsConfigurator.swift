//
//  ProjectDetailsConfigurator.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//


import Foundation

protocol ProjectDetailsConfigurator {
	func configure(projectDetailsTableViewController: ProjectDetailsTableViewController)
}

class ProjectDetailsConfiguratorImplementation: ProjectDetailsConfigurator {
	let project: Project
	
	init(project: Project) {
		self.project = project
	}
	
	func configure(projectDetailsTableViewController: ProjectDetailsTableViewController) {
		let router = ProjectDetailsViewRouterImplementation(projectDetailsTableViewController: projectDetailsTableViewController)
		
        let presenter = ProjectDetailsPresenterImplementation(view: projectDetailsTableViewController,
		                                     project: project,
		                                     router: router)

		projectDetailsTableViewController.presenter = presenter
	}
}
