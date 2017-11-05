//
//  PhotoDetailsPresenter.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//


import Foundation

protocol PhotoDetailsView: class {
    func display(createdAt: String)
    func display(updatedAt: String)
    func display(dimensions: String)
    func display(likes: String)
    func display(description: String)
    func display(username: String)
    func display(largePhotoUrl: String)
//    func display(dominantObject: String)
    func refreshKeywordsView()
}

protocol PhotoKeywordView {
    func display(keyword: String)
}

protocol PhotoDetailsPresenter {
    var numberOfKeywords: Int { get }
	var router: PhotoDetailsViewRouter { get }
	func viewDidLoad()
    func configure(cell: PhotoKeywordCell, forRow row: Int)
    func didSelect(row: Int)
}

class PhotoDetailsPresenterImplementation: PhotoDetailsPresenter {
	fileprivate let photo: Photo
    fileprivate var dominantCategory: String?
    fileprivate let detectPhotoUseCase: DetectPhotoUseCase
	let router: PhotoDetailsViewRouter
	fileprivate weak var view: PhotoDetailsView?
    
    var autoDetectedKeywords = [String]()
    var numberOfKeywords: Int {
        return autoDetectedKeywords.count
    }
    
	init(view: PhotoDetailsView,
         detectPhotoUseCase: DetectPhotoUseCase,
	     photo: Photo,
	     router: PhotoDetailsViewRouter) {
		self.view = view
        self.detectPhotoUseCase = detectPhotoUseCase
		self.photo = photo
		self.router = router
	}
	
	func viewDidLoad() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        view?.display(createdAt: formatter.string(from: photo.createdAt))
        view?.display(updatedAt: formatter.string(from: photo.updatedAt))
        
        view?.display(dimensions: "\(photo.width) by \(photo.height)")
        view?.display(likes: "\(photo.likes)")
        view?.display(description: photo.description ?? "なし")
        view?.display(username: photo.username)
        view?.display(largePhotoUrl: photo.urls.regular)
        
        let params = DetectPhotoParameters(photoUrl: photo.urls.small)
        self.detectPhotoUseCase.detectDominant(parameters: params) { [unowned self] result in
            switch result {
            case .success(let identifiers):
                self.handleDetectionSuccess(identifiers)
            case .failure:
                break
            }
        }
	}
    
    func configure(cell: PhotoKeywordCell, forRow row: Int) {
        let autoDetectedKeyword = autoDetectedKeywords[row]
        cell.display(keyword: autoDetectedKeyword)
    }
    
    func didSelect(row: Int) {
        let autoDetectedKeyword = autoDetectedKeywords[row]
        router.presentSearchView(for: autoDetectedKeyword)
    }
    
    // MARK: - Private
    fileprivate func handleDetectionSuccess(_ keywords: [String]) {
        autoDetectedKeywords = keywords
        view?.refreshKeywordsView()
    }
}
