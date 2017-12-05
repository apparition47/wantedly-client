//
//  ProjectsFeaturedPresenter.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/05.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol ProjectsFeaturedView: class {
    func refreshProjectsView()
    func displayProjectsRetrievalError(title: String, message: String)
    func updateBackground(hexColour: String)
}

protocol ProjectsFeaturedPresenter {
    var numberOfProjects: Int { get }
    var router: ProjectsFeaturedViewRouter { get }
    func viewDidLoad()
    func configure(cell: ProjectCollectionViewCell, forRow row: Int)
    func didSelect(row: Int)
    func didSnap(to row: Int)
    func didScrollViewToEnd()
}

class ProjectsFeaturedPresenterImplementation: ProjectsFeaturedPresenter {
    fileprivate weak var view: ProjectsFeaturedView?
    fileprivate let getProjectsUseCase: SearchProjectsUseCase
    internal let router: ProjectsFeaturedViewRouter
    
    // Normally this would be file private as well, we keep it internal so we can inject values for testing purposes
    var projects = [Project]()
    
    private var currentPage = 0
    private let pageSize = 5
    private var lastSearchQuery = ""
    
    var numberOfProjects: Int {
        return projects.count
    }
    
    init(view: ProjectsFeaturedView,
         getProjectsUseCase: SearchProjectsUseCase,
         router: ProjectsFeaturedViewRouter) {
        self.view = view
        self.getProjectsUseCase = getProjectsUseCase
        self.router = router
    }
    
    
    // MARK: - ProjectsPresenter
    
    func viewDidLoad() {
        fetchProjects()
    }
    
    func configure(cell: ProjectCollectionViewCell, forRow row: Int) {
        let project = projects[row]

        cell.display(createdAt: project.hiring)
        cell.display(username: project.title)
        cell.display(thumbnailUrl: project.images.icon304Retina)
    }
    
    func didSelect(row: Int) {
        let project = projects[row]
        
        router.presentDetailsView(for: project)
    }

    func didSnap(to row: Int) {
//        view?.updateBackground(hexColour: projects[row].colour)
    }
    
    func didScrollViewToEnd() {
        fetchProjects()
    }
    
    // MARK: - Private
    private func fetchProjects() {
        currentPage += 1
        let params: SearchProjectsParameters = SearchProjectsParameters(query: nil, page: currentPage)

        getProjectsUseCase.search(parameters: params) { result in
            switch result {
            case let .success(projects):
                self.handleProjectsReceived(projects)
            case let .failure(error):
                self.currentPage -= 1
                self.handleProjectsError(error)
            }
        }
    }
    
    fileprivate func handleProjectsReceived(_ projects: [Project]) {
        self.projects += projects
        view?.refreshProjectsView()
    }
    
    fileprivate func handleProjectsError(_ error: Error) {
        view?.displayProjectsRetrievalError(title: "Error", message: error.localizedDescription)
    }
}
