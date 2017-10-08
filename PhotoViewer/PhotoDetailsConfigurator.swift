//
//  PhotoDetailsConfigurator.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/09/02.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//


import Foundation

protocol PhotoDetailsConfigurator {
	func configure(photoDetailsTableViewController: PhotoDetailsTableViewController)
}

class PhotoDetailsConfiguratorImplementation: PhotoDetailsConfigurator {
	let photo: Photo
	
	init(photo: Photo) {
		self.photo = photo
	}
	
	func configure(photoDetailsTableViewController: PhotoDetailsTableViewController) {
		let router = PhotoDetailsViewRouterImplementation(photoDetailsTableViewController: photoDetailsTableViewController)
		
        let mlGateway = MLGatewayImplementation()
        let detectPhotoUseCase = DetectPhotoUseCaseImplementation(mlGateway: mlGateway)
        
        let presenter = PhotoDetailsPresenterImplementation(view: photoDetailsTableViewController,
                                                            detectPhotoUseCase: detectPhotoUseCase,
		                                     photo: photo,
		                                     router: router)

		photoDetailsTableViewController.presenter = presenter
	}
}