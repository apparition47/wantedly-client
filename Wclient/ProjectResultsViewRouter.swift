//
//  ProjectResultsViewRouter.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

protocol ProjectResultsViewRouter: ViewRouter {
    func presentDetailsView(for project: Project)
}

class ProjectResultsViewRouterImplementation: ProjectResultsViewRouter {
    struct Segue {
        static let ProjectsSceneToProjectDetailsScene = "ProjectsSceneToProjectDetailsSceneSegue"
    }
    
    fileprivate weak var projectResultsViewController: ProjectResultsViewController?
    fileprivate var project: Project!
    
    init(projectResultsViewController: ProjectResultsViewController) {
        self.projectResultsViewController = projectResultsViewController
    }
    
    // MARK: - ProjectsViewRouter
    
    func presentDetailsView(for project: Project) {
        self.project = project
        projectResultsViewController?.performSegue(withIdentifier: Segue.ProjectsSceneToProjectDetailsScene, sender: nil)
    }

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let projectDetailsTableViewController = segue.destination as? ProjectDetailsTableViewController {
            projectDetailsTableViewController.configurator = ProjectDetailsConfiguratorImplementation(project: project)
        }
    }
    
}
