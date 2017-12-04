//
//  ProjectsFeaturedViewRouter.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/05.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

protocol ProjectsFeaturedViewRouter: ViewRouter {
    func presentDetailsView(for Project: Project)
}

class ProjectsFeaturedViewRouterImplementation: ProjectsFeaturedViewRouter {
    struct Segue {
        static let ProjectsFeaturedSceneToProjectDetailsScene = "ProjectsFeaturedSceneToProjectDetailsSceneSegue"
    }
    
    fileprivate weak var ProjectsFeaturedViewController: ProjectsFeaturedViewController?
    fileprivate var Project: Project!
    
    init(ProjectsFeaturedViewController: ProjectsFeaturedViewController) {
        self.ProjectsFeaturedViewController = ProjectsFeaturedViewController
    }
    
    // MARK: - ProjectsViewRouter
    
    func presentDetailsView(for Project: Project) {
        self.Project = Project
        ProjectsFeaturedViewController?.performSegue(withIdentifier: Segue.ProjectsFeaturedSceneToProjectDetailsScene, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ProjectDetailsTableViewController = segue.destination as? ProjectDetailsTableViewController {
            ProjectDetailsTableViewController.configurator = ProjectDetailsConfiguratorImplementation(Project: Project)
        }
    }
    
}

