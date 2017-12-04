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
    fileprivate let getProjectsUseCase: GetProjectsUseCase
    internal let router: ProjectsFeaturedViewRouter
    
    // Normally this would be file private as well, we keep it internal so we can inject values for testing purposes
    var Projects = [Project]()
    
    private var currentPage = 0
    private let pageSize = 5
    private var lastSearchQuery = ""
    
    var numberOfProjects: Int {
        return Projects.count
    }
    
    init(view: ProjectsFeaturedView,
         getProjectsUseCase: GetProjectsUseCase,
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
        let Project = Projects[row]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        cell.display(createdAt: formatter.string(from: Project.createdAt))
        cell.display(username: Project.username)
        cell.display(thumbnailUrl: Project.urls.small)
    }
    
    func didSelect(row: Int) {
        let Project = Projects[row]
        
        router.presentDetailsView(for: Project)
    }

    func didSnap(to row: Int) {
        view?.updateBackground(hexColour: Projects[row].colour)
    }
    
    func didScrollViewToEnd() {
        fetchProjects()
    }
    
    // MARK: - Private
    private func fetchProjects() {
        currentPage += 1
        let params: FetchProjectsParameters = FetchProjectsParameters(page: currentPage, perPage: pageSize, orderBy: OrderBy.Latest)

        getProjectsUseCase.fetchProjects(parameters: params) { result in
            switch result {
            case let .success(Projects):
                self.handleProjectsReceived(Projects)
            case let .failure(error):
                self.currentPage -= 1
                self.handleProjectsError(error)
            }
        }
    }
    
    fileprivate func handleProjectsReceived(_ Projects: [Project]) {
        self.Projects += Projects
        view?.refreshProjectsView()
    }
    
    fileprivate func handleProjectsError(_ error: Error) {
        view?.displayProjectsRetrievalError(title: "Error", message: error.localizedDescription)
    }
}
