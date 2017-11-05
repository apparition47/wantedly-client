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
    func display(dominantObject: String)
}

protocol PhotoDetailsPresenter {
	var router: PhotoDetailsViewRouter { get }
	func viewDidLoad()
}

class PhotoDetailsPresenterImplementation: PhotoDetailsPresenter {
	fileprivate let photo: Photo
    fileprivate let detectPhotoUseCase: DetectPhotoUseCase
	let router: PhotoDetailsViewRouter
	fileprivate weak var view: PhotoDetailsView?
	
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
            case .success(let cat):
                DispatchQueue.main.async {
                    self.view?.display(dominantObject: cat)
                }
            case .failure:
                break
            }
        }
	}
}
