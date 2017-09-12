//
//  PhotosPresenter.swift
//  Library
//
//  Created by Aaron Lee on 2017/08/27.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import Foundation

protocol PhotosView: class {
    func refreshPhotosView()
    func displayPhotosRetrievalError(title: String, message: String)
}

protocol PhotoCellView {
    func display(createdAt: String)
    func display(username: String)
    func display(thumbnailUrl: String)
}

protocol PhotosPresenter {
    var numberOfPhotos: Int { get }
    var router: PhotosViewRouter { get }
    func viewDidLoad()
    func configure(cell: PhotoCellView, forRow row: Int)
    func didSelect(row: Int)
    func didSearch(query: String)
//    func titleForDeleteButton(row: Int) -> String
//    func deleteButtonPressed(row: Int)
//    func addButtonPressed()
}

class PhotosPresenterImplementation: PhotosPresenter {
    fileprivate weak var view: PhotosView?
    fileprivate let getPhotosUseCase: GetPhotosUseCase
    fileprivate let searchPhotosUseCase: SearchPhotosUseCase
    internal let router: PhotosViewRouter
    
    // Normally this would be file private as well, we keep it internal so we can inject values for testing purposes
    var photos = [Photo]()
    
    var numberOfPhotos: Int {
        return photos.count
    }
    
    init(view: PhotosView,
         getPhotosUseCase: GetPhotosUseCase,
         searchPhotosUseCase: SearchPhotosUseCase,
         router: PhotosViewRouter) {
        self.view = view
        self.getPhotosUseCase = getPhotosUseCase
        self.searchPhotosUseCase = searchPhotosUseCase
        self.router = router
        
//        registerForSearchPhotosNotifications()
    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
    
    // MARK: - PhotosPresenter
    
    func viewDidLoad() {
        let params: FetchPhotosParameters = FetchPhotosParameters(page: 0, perPage: 10, orderBy: OrderBy.Latest)
        
        self.getPhotosUseCase.fetchPhotos(parameters: params) { (result) in
            switch result {
            case let .success(photos):
                self.handlePhotosReceived(photos)
            case let .failure(error):
                self.handlePhotosError(error)
            }
        }
    }
    
    func configure(cell: PhotoCellView, forRow row: Int) {
        let photo = photos[row]
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        cell.display(createdAt: formatter.string(from: photo.createdAt))
        
        cell.display(username: photo.username!)
        cell.display(thumbnailUrl: photo.urls.thumb)
    }
    
    func didSelect(row: Int) {
        let photo = photos[row]
        
        router.presentDetailsView(for: photo)
    }
    
    func didSearch(query: String) {
        let params = SearchPhotosParameters(query: query, page: 0, perPage: nil, collections: nil)
        self.searchPhotosUseCase.search(parameters: params) { (result) in
            switch result {
            case let .success(photos):
                self.handlePhotosSearched(photos: photos)
            case let .failure(error):
                self.handlePhotosError(error)
            }
        }
    }
    
//    func canEdit(row: Int) -> Bool {
//        return true
//    }
    
//    func titleForDeleteButton(row: Int) -> String {
//        return "Delete Book"
//    }
    
//    func deleteButtonPressed(row: Int) {
//        view?.endEditing()
//        
//        let book = books[row]
//        deleteBookUseCase.delete(book: book) { (result) in
//            switch result {
//            case .success():
//                self.handleBookDeleted(book: book)
//            case let .failure(error):
//                self.handleBookDeleteError(error)
//            }
//        }
//    }
    
//    func addButtonPressed() {
//        router.presentAddBook(addBookPresenterDelegate: self)
//    }
    
    // MARK: - AddBookPresenterDelegate
    
//    func addBookPresenter(_ presenter: AddBookPresenter, didAdd book: Book) {
//        presenter.router.dismiss()
//        books.append(book)
//        view?.refreshBooksView()
//    }
    
//    func addBookPresenterCancel(presenter: AddBookPresenter) {
//        presenter.router.dismiss()
//    }
    
    // MARK: - Private
    
    fileprivate func handlePhotosReceived(_ photos: [Photo]) {
        self.photos = photos
        view?.refreshPhotosView()
    }
    
    fileprivate func handlePhotosError(_ error: Error) {
        // Here we could check the error code and display a localized error message
        view?.displayPhotosRetrievalError(title: "Error", message: error.localizedDescription)
    }
//
//    fileprivate func registerForSearchPhotosNotifications() {
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(didReceiveSearchPhotosNotification),
//                                               name: SearchPhotosUseCaseNotifications.didSearchPhotos,
//                                               object: nil)
//    }
    
//    @objc fileprivate func didReceiveSearchPhotosNotification(_ notification: Notification) {
//        if let photos = notification.object as? [Photo] {
//            handlePhotosSearched(photos: photos)
//        }
//    }
    
    fileprivate func handlePhotosSearched(photos: [Photo]) {
        self.photos = photos
        view?.refreshPhotosView()
    }
    
//    fileprivate func handleBookDeleteError(_ error: Error) {
//        // Here we could check the error code and display a localized error message
//        view?.displayBookDeleteError(title: "Error", message: error.localizedDescription)
//    }
}
