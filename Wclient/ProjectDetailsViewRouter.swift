//
//  ProjectDetailsViewRouter.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

protocol ProjectDetailsViewRouter: ViewRouter {
	func dismissView()
    func presentSearchView(for query: String) 
}

class ProjectDetailsViewRouterImplementation: ProjectDetailsViewRouter {
    struct Segue {
        static let ProjectDetailsSceneToProjectSearchSceneSegue = "ProjectDetailsSceneToProjectSearchSceneSegue"
    }
    
	fileprivate weak var projectDetailsTableViewController: ProjectDetailsTableViewController?
    fileprivate var query: String!
	
	init(projectDetailsTableViewController: ProjectDetailsTableViewController) {
		self.projectDetailsTableViewController = projectDetailsTableViewController
	}
	
	func dismissView() {
		let _ = projectDetailsTableViewController?.navigationController?.popViewController(animated: true)
	}
    
    // MARK: - ProjectsViewRouter
    
    func presentSearchView(for query: String) {
        self.query = query
        projectDetailsTableViewController?.performSegue(withIdentifier: Segue.ProjectDetailsSceneToProjectSearchSceneSegue, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let projectResultsViewController = segue.destination as? ProjectResultsViewController {
            projectResultsViewController.configurator = ProjectResultsConfiguratorImplementation(query: query)
        }
    }
}
