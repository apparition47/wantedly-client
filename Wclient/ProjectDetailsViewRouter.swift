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
    
	fileprivate weak var ProjectDetailsTableViewController: ProjectDetailsTableViewController?
    fileprivate var query: String!
	
	init(ProjectDetailsTableViewController: ProjectDetailsTableViewController) {
		self.ProjectDetailsTableViewController = ProjectDetailsTableViewController
	}
	
	func dismissView() {
		let _ = ProjectDetailsTableViewController?.navigationController?.popViewController(animated: true)
	}
    
    // MARK: - ProjectsViewRouter
    
    func presentSearchView(for query: String) {
        self.query = query
        ProjectDetailsTableViewController?.performSegue(withIdentifier: Segue.ProjectDetailsSceneToProjectSearchSceneSegue, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ProjectResultsViewController = segue.destination as? ProjectResultsViewController {
            ProjectResultsViewController.configurator = ProjectResultsConfiguratorImplementation(query: query)
        }
    }
}
