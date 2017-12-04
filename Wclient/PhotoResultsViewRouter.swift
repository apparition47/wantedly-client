//
//  PhotoResultsViewRouter.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

protocol PhotoResultsViewRouter: ViewRouter {
    func presentDetailsView(for photo: Photo)
}

class PhotoResultsViewRouterImplementation: PhotoResultsViewRouter {
    struct Segue {
        static let photosSceneToPhotoDetailsScene = "PhotosSceneToPhotoDetailsSceneSegue"
    }
    
    fileprivate weak var photoResultsViewController: PhotoResultsViewController?
    fileprivate var photo: Photo!
    
    init(photoResultsViewController: PhotoResultsViewController) {
        self.photoResultsViewController = photoResultsViewController
    }
    
    // MARK: - PhotosViewRouter
    
    func presentDetailsView(for photo: Photo) {
        self.photo = photo
        photoResultsViewController?.performSegue(withIdentifier: Segue.photosSceneToPhotoDetailsScene, sender: nil)
    }

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photoDetailsTableViewController = segue.destination as? PhotoDetailsTableViewController {
            photoDetailsTableViewController.configurator = PhotoDetailsConfiguratorImplementation(photo: photo)
        }
    }
    
}
