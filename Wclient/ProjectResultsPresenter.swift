//
//  ProjectResultsPresenter.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol ProjectsView: class {
    func updateTitleBar(givenTitle: String)
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
    var Projects = [Project]()
    
    private var currentPage = 0
    private let pageSize = 10
    
    var numberOfProjects: Int {
        return Projects.count
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
        view?.updateTitleBar(givenTitle: query)
        didSearch(query, clearOldResults: true)
    }
    
    func configure(cell: ProjectCellView, forRow row: Int) {
        let Project = Projects[row]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        cell.display(createdAt: formatter.string(from: Project.createdAt))
        cell.display(username: Project.username)
        cell.display(thumbnailUrl: Project.urls.thumb)
    }
    
    func didSelect(row: Int) {
        let Project = Projects[row]
        
        router.presentDetailsView(for: Project)
    }
    
    func didSearch(_ query: String, clearOldResults: Bool) {
        self.query = query
        
        if clearOldResults {
            currentPage = 0
            Projects.removeAll()
        }
        
        currentPage += 1
        
        let params = SearchProjectsParameters(query: query, page: currentPage, perPage: pageSize, collections: nil)
        self.searchProjectsUseCase.search(parameters: params) { result in
            switch result {
            case let .success(Projects):
                self.handleProjectsSearched(Projects: Projects)
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
    
    fileprivate func handleProjectsReceived(_ Projects: [Project]) {
        self.Projects += Projects
        view?.refreshProjectsView()
    }
    
    fileprivate func handleProjectsError(_ error: Error) {
        // Here we could check the error code and display a localized error message
        view?.displayProjectsRetrievalError(title: "Error", message: error.localizedDescription)
    }
    
    fileprivate func handleProjectsSearched(Projects: [Project]) {
        self.Projects += Projects
        view?.refreshProjectsView()
    }
}
