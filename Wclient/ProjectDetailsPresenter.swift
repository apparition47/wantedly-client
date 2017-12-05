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
//    func display(updatedAt: String)
//    func display(dimensions: String)
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
//    var numberOfKeywords: Int { get }
	var router: ProjectDetailsViewRouter { get }
	func viewDidLoad()
//    func configure(cell: ProjectKeywordCell, forRow row: Int)
//    func didSelect(row: Int)
}

class ProjectDetailsPresenterImplementation: ProjectDetailsPresenter {
	fileprivate let project: Project
	let router: ProjectDetailsViewRouter
	fileprivate weak var view: ProjectDetailsView?
    
//    var autoDetectedKeywords = [String]()
//    var numberOfKeywords: Int {
//        return autoDetectedKeywords.count
//    }
    
	init(view: ProjectDetailsView,
	     project: Project,
	     router: ProjectDetailsViewRouter) {
		self.view = view
		self.project = project
		self.router = router
	}
	
	func viewDidLoad() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        view?.display(createdAt: formatter.string(from: project.publishedAt))
//        view?.display(updatedAt: formatter.string(from: Project.updatedAt))
        
//        view?.display(dimensions: "\(project.width) by \(project.height)")
        view?.display(likes: "\(project.supporterCount)")
        view?.display(description: project.description)
        view?.display(username: project.title)
        view?.display(largeProjectUrl: project.images.original)
        
	}
    
//    func configure(cell: ProjectKeywordCell, forRow row: Int) {
//        let autoDetectedKeyword = autoDetectedKeywords[row]
//        cell.display(keyword: autoDetectedKeyword)
//    }
    
//    func didSelect(row: Int) {
//        let autoDetectedKeyword = autoDetectedKeywords[row]
//        router.presentSearchView(for: autoDetectedKeyword)
//    }
    
    // MARK: - Private
//    fileprivate func handleDetectionSuccess(_ keywords: [String]) {
//        autoDetectedKeywords = keywords
//        view?.refreshKeywordsView()
//    }
}
