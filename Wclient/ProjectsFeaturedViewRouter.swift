//
//  ProjectsFeaturedViewRouter.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/05.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

protocol ProjectsFeaturedViewRouter: ViewRouter {
    func presentDetailsView(for project: Project)
}

class ProjectsFeaturedViewRouterImplementation: ProjectsFeaturedViewRouter {
    struct Segue {
        static let ProjectsFeaturedSceneToProjectDetailsScene = "ProjectsFeaturedSceneToProjectDetailsSceneSegue"
    }
    
    fileprivate weak var projectsFeaturedViewController: ProjectsFeaturedViewController?
    fileprivate var project: Project!
    
    init(projectsFeaturedViewController: ProjectsFeaturedViewController) {
        self.projectsFeaturedViewController = projectsFeaturedViewController
    }
    
    // MARK: - ProjectsViewRouter
    
    func presentDetailsView(for project: Project) {
        self.project = project
        projectsFeaturedViewController?.performSegue(withIdentifier: Segue.ProjectsFeaturedSceneToProjectDetailsScene, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let projectDetailsTableViewController = segue.destination as? ProjectDetailsTableViewController {
            projectDetailsTableViewController.configurator = ProjectDetailsConfiguratorImplementation(project: project)
        }
    }
    
}

