//
//  ProjectResultsPresenter.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol ProjectsView: class {
    func refreshProjectsView()
    func displayProjectsRetrievalError(title: String, message: String)
}

protocol ProjectCellView {
    func display(createdAt: String)
    func display(username: String)
    func display(thumbnailUrl: String)
}

protocol ProjectResultsPresenter {
    var numberOfProjects: Int { get }
    var router: ProjectResultsViewRouter { get }
    func viewDidLoad()
    func configure(cell: ProjectCellView, forRow row: Int)
    func didSelect(row: Int)
    func didSearch(_ query: String, clearOldResults: Bool)
    func didScrollViewToBottom()
}

class ProjectResultsPresenterImplementation: ProjectResultsPresenter {
    fileprivate var query: String
    fileprivate weak var view: ProjectsView?
    fileprivate let searchProjectsUseCase: SearchProjectsUseCase
    internal let router: ProjectResultsViewRouter
    
    // Normally this would be file private as well, we keep it internal so we can inject values for testing purposes
    var projects = [Project]()
    
    private var currentPage = 0
    private let pageSize = 10
    
    var numberOfProjects: Int {
        return projects.count
    }
    
    init(view: ProjectsView,
         searchProjectsUseCase: SearchProjectsUseCase,
         query: String,
         router: ProjectResultsViewRouter) {
        self.view = view
        self.searchProjectsUseCase = searchProjectsUseCase
        self.query = query
        self.router = router
    }
    
    
    // MARK: - ProjectsPresenter
    
    func viewDidLoad() {
        didSearch(query, clearOldResults: true)
    }
    
    func configure(cell: ProjectCellView, forRow row: Int) {
        let project = projects[row]
        
        cell.display(createdAt: project.hiring)
        cell.display(username: project.title)
        if let iUrl = project.images?.icon105Retina {
            cell.display(thumbnailUrl: iUrl)
        }
    }
    
    func didSelect(row: Int) {
        let project = projects[row]
        
        router.presentDetailsView(for: project)
    }
    
    func didSearch(_ query: String, clearOldResults: Bool) {
        self.query = query
        
        if clearOldResults {
            currentPage = 0
            projects.removeAll()
        }
        
        currentPage += 1
        
        let params = SearchProjectsParameters(query: query, page: currentPage)
        self.searchProjectsUseCase.search(parameters: params) { result in
            switch result {
            case let .success(projects):
                self.handleProjectsSearched(projects: projects)
            case let .failure(error):
                self.currentPage -= 1
                self.handleProjectsError(error)
            }
        }
    }
    
    func didScrollViewToBottom() {
        didSearch(query, clearOldResults: false)
    }

    // MARK: - Private
    
    fileprivate func handleProjectsReceived(_ projects: [Project]) {
        self.projects += projects
        view?.refreshProjectsView()
    }
    
    fileprivate func handleProjectsError(_ error: Error) {
        // Here we could check the error code and display a localized error message
        view?.displayProjectsRetrievalError(title: "Error", message: error.localizedDescription)
    }
    
    fileprivate func handleProjectsSearched(projects: [Project]) {
        self.projects += projects
        view?.refreshProjectsView()
    }
}
