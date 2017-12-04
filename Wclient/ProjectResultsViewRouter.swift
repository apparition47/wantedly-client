//
//  ProjectResultsViewRouter.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

protocol ProjectResultsViewRouter: ViewRouter {
    func presentDetailsView(for Project: Project)
}

class ProjectResultsViewRouterImplementation: ProjectResultsViewRouter {
    struct Segue {
        static let ProjectsSceneToProjectDetailsScene = "ProjectsSceneToProjectDetailsSceneSegue"
    }
    
    fileprivate weak var ProjectResultsViewController: ProjectResultsViewController?
    fileprivate var Project: Project!
    
    init(ProjectResultsViewController: ProjectResultsViewController) {
        self.ProjectResultsViewController = ProjectResultsViewController
    }
    
    // MARK: - ProjectsViewRouter
    
    func presentDetailsView(for Project: Project) {
        self.Project = Project
        ProjectResultsViewController?.performSegue(withIdentifier: Segue.ProjectsSceneToProjectDetailsScene, sender: nil)
    }

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ProjectDetailsTableViewController = segue.destination as? ProjectDetailsTableViewController {
            ProjectDetailsTableViewController.configurator = ProjectDetailsConfiguratorImplementation(Project: Project)
        }
    }
    
}
