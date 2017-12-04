//
//  PhotosFeaturedViewRouter.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/05.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

protocol PhotosFeaturedViewRouter: ViewRouter {
    func presentDetailsView(for photo: Photo)
}

class PhotosFeaturedViewRouterImplementation: PhotosFeaturedViewRouter {
    struct Segue {
        static let photosFeaturedSceneToPhotoDetailsScene = "PhotosFeaturedSceneToPhotoDetailsSceneSegue"
    }
    
    fileprivate weak var photosFeaturedViewController: PhotosFeaturedViewController?
    fileprivate var photo: Photo!
    
    init(photosFeaturedViewController: PhotosFeaturedViewController) {
        self.photosFeaturedViewController = photosFeaturedViewController
    }
    
    // MARK: - PhotosViewRouter
    
    func presentDetailsView(for photo: Photo) {
        self.photo = photo
        photosFeaturedViewController?.performSegue(withIdentifier: Segue.photosFeaturedSceneToPhotoDetailsScene, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photoDetailsTableViewController = segue.destination as? PhotoDetailsTableViewController {
            photoDetailsTableViewController.configurator = PhotoDetailsConfiguratorImplementation(photo: photo)
        }
    }
    
}

