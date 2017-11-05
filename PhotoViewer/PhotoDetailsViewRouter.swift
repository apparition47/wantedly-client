//
//  PhotoDetailsViewRouter.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

protocol PhotoDetailsViewRouter: ViewRouter {
	func dismissView()
    func presentSearchView(for query: String) 
}

class PhotoDetailsViewRouterImplementation: PhotoDetailsViewRouter {
	fileprivate weak var photoDetailsTableViewController: PhotoDetailsTableViewController?
    fileprivate var query: String!
	
	init(photoDetailsTableViewController: PhotoDetailsTableViewController) {
		self.photoDetailsTableViewController = photoDetailsTableViewController
	}
	
	func dismissView() {
		let _ = photoDetailsTableViewController?.navigationController?.popViewController(animated: true)
	}
    
    // MARK: - PhotosViewRouter
    
    func presentSearchView(for query: String) {
        self.query = query
        photoDetailsTableViewController?.performSegue(withIdentifier: "PhotoDetailsSceneToPhotoSearchSceneSegue", sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photosCollectionViewController = segue.destination as? PhotosCollectionViewController {
            photosCollectionViewController.configurator = PhotosConfiguratorImplementation(query: query)
        }
    }
}
