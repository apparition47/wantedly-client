//
//  PhotoResultsPresenter.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol PhotosView: class {
    func updateTitleBar(givenTitle: String)
    func refreshPhotosView()
    func displayPhotosRetrievalError(title: String, message: String)
}

protocol PhotoCellView {
    func display(createdAt: String)
    func display(username: String)
    func display(thumbnailUrl: String)
}

protocol PhotoResultsPresenter {
    var numberOfPhotos: Int { get }
    var router: PhotoResultsViewRouter { get }
    func viewDidLoad()
    func configure(cell: PhotoCellView, forRow row: Int)
    func didSelect(row: Int)
    func didSearch(_ query: String, clearOldResults: Bool)
    func didScrollViewToBottom()
}

class PhotoResultsPresenterImplementation: PhotoResultsPresenter {
    fileprivate var query: String
    fileprivate weak var view: PhotosView?
    fileprivate let searchPhotosUseCase: SearchPhotosUseCase
    internal let router: PhotoResultsViewRouter
    
    // Normally this would be file private as well, we keep it internal so we can inject values for testing purposes
    var photos = [Photo]()
    
    private var currentPage = 0
    private let pageSize = 10
    
    var numberOfPhotos: Int {
        return photos.count
    }
    
    init(view: PhotosView,
         searchPhotosUseCase: SearchPhotosUseCase,
         query: String,
         router: PhotoResultsViewRouter) {
        self.view = view
        self.searchPhotosUseCase = searchPhotosUseCase
        self.query = query
        self.router = router
    }
    
    
    // MARK: - PhotosPresenter
    
    func viewDidLoad() {
        view?.updateTitleBar(givenTitle: query)
        didSearch(query, clearOldResults: true)
    }
    
    func configure(cell: PhotoCellView, forRow row: Int) {
        let photo = photos[row]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        cell.display(createdAt: formatter.string(from: photo.createdAt))
        cell.display(username: photo.username)
        cell.display(thumbnailUrl: photo.urls.thumb)
    }
    
    func didSelect(row: Int) {
        let photo = photos[row]
        
        router.presentDetailsView(for: photo)
    }
    
    func didSearch(_ query: String, clearOldResults: Bool) {
        self.query = query
        
        if clearOldResults {
            currentPage = 0
            photos.removeAll()
        }
        
        currentPage += 1
        
        let params = SearchPhotosParameters(query: query, page: currentPage, perPage: pageSize, collections: nil)
        self.searchPhotosUseCase.search(parameters: params) { result in
            switch result {
            case let .success(photos):
                self.handlePhotosSearched(photos: photos)
            case let .failure(error):
                self.currentPage -= 1
                self.handlePhotosError(error)
            }
        }
    }
    
    func didScrollViewToBottom() {
        didSearch(query, clearOldResults: false)
    }

    // MARK: - Private
    
    fileprivate func handlePhotosReceived(_ photos: [Photo]) {
        self.photos += photos
        view?.refreshPhotosView()
    }
    
    fileprivate func handlePhotosError(_ error: Error) {
        // Here we could check the error code and display a localized error message
        view?.displayPhotosRetrievalError(title: "Error", message: error.localizedDescription)
    }
    
    fileprivate func handlePhotosSearched(photos: [Photo]) {
        self.photos += photos
        view?.refreshPhotosView()
    }
}
