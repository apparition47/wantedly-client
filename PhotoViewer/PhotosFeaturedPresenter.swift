//
//  PhotosFeaturedPresenter.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import Foundation

protocol PhotosFeaturedView: class {
    func refreshPhotosView()
    func displayPhotosRetrievalError(title: String, message: String)
    func updateBackground(hexColour: String)
}

//protocol PhotoFeaturedCellView {
//    func display(createdAt: String)
//    func display(username: String)
//    func display(thumbnailUrl: String)
//}

protocol PhotosFeaturedPresenter {
    var numberOfPhotos: Int { get }
    var router: PhotosFeaturedViewRouter { get }
    func viewDidLoad()
    func configure(cell: PhotoCollectionViewCell, forRow row: Int)
    func didSelect(row: Int)
    func didSnap(to row: Int)
    func didScrollViewToEnd()
}

class PhotosFeaturedPresenterImplementation: PhotosFeaturedPresenter {
    fileprivate weak var view: PhotosFeaturedView?
    fileprivate let getPhotosUseCase: GetPhotosUseCase
    internal let router: PhotosFeaturedViewRouter
    
    // Normally this would be file private as well, we keep it internal so we can inject values for testing purposes
    var photos = [Photo]()
    
    private var currentPage = 0
    private let pageSize = 5
    private var lastSearchQuery = ""
    
    var numberOfPhotos: Int {
        return photos.count
    }
    
    init(view: PhotosFeaturedView,
         getPhotosUseCase: GetPhotosUseCase,
         router: PhotosFeaturedViewRouter) {
        self.view = view
        self.getPhotosUseCase = getPhotosUseCase
        self.router = router
    }
    
    
    // MARK: - PhotosPresenter
    
    func viewDidLoad() {
        fetchPhotos()
    }
    
    func configure(cell: PhotoCollectionViewCell, forRow row: Int) {
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

    func didSnap(to row: Int) {
        view?.updateBackground(hexColour: photos[row].colour)
    }
    
    func didScrollViewToEnd() {
        fetchPhotos()
    }
    
    // MARK: - Private
    private func fetchPhotos() {
        currentPage += 1
        let params: FetchPhotosParameters = FetchPhotosParameters(page: currentPage, perPage: pageSize, orderBy: OrderBy.Latest)

        getPhotosUseCase.fetchPhotos(parameters: params) { result in
            switch result {
            case let .success(photos):
                self.handlePhotosReceived(photos)
            case let .failure(error):
                self.currentPage -= 1
                self.handlePhotosError(error)
            }
        }
    }
    
    fileprivate func handlePhotosReceived(_ photos: [Photo]) {
        self.photos += photos
        view?.refreshPhotosView()
    }
    
    fileprivate func handlePhotosError(_ error: Error) {
        // Here we could check the error code and display a localized error message
        view?.displayPhotosRetrievalError(title: "Error", message: error.localizedDescription)
    }
}
