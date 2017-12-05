//
//  ProjectDetailsPresenter.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//


import Foundation

protocol ProjectDetailsView: class {
    func display(createdAt: String)
    func display(updatedAt: String)
    func display(dimensions: String)
    func display(likes: String)
    func display(description: String)
    func display(username: String)
    func display(largeProjectUrl: String)
//    func display(dominantObject: String)
//    func refreshKeywordsView()
}

protocol ProjectKeywordView {
    func display(keyword: String)
}

protocol ProjectDetailsPresenter {
	var router: ProjectDetailsViewRouter { get }
	func viewDidLoad()
}

class ProjectDetailsPresenterImplementation: ProjectDetailsPresenter {
	fileprivate let project: Project
	let router: ProjectDetailsViewRouter
	fileprivate weak var view: ProjectDetailsView?
    
	init(view: ProjectDetailsView,
	     project: Project,
	     router: ProjectDetailsViewRouter) {
		self.view = view
		self.project = project
		self.router = router
	}
	
	func viewDidLoad() {
        view?.display(createdAt: "\(project.staffCount)")
        view?.display(updatedAt: "\(project.pageViews)")
        view?.display(dimensions: project.address)
        view?.display(likes: "\(project.supporterCount)")
        view?.display(description: project.description ?? "N/A")
        view?.display(username: project.title)
        view?.display(largeProjectUrl: project.images.original)
	}
}
