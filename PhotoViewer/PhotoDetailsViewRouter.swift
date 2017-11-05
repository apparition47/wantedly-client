//
//  PhotoDetailsViewRouter.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol PhotoDetailsViewRouter: ViewRouter {
	func dismissView()
}

class PhotoDetailsViewRouterImplementation: PhotoDetailsViewRouter {
	fileprivate weak var photoDetailsTableViewController: PhotoDetailsTableViewController?
	
	init(photoDetailsTableViewController: PhotoDetailsTableViewController) {
		self.photoDetailsTableViewController = photoDetailsTableViewController
	}
	
	func dismissView() {
		let _ = photoDetailsTableViewController?.navigationController?.popViewController(animated: true)
	}
}
