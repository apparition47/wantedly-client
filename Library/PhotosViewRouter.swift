//
//  PhotosViewRouter.swift
//  Library
//
//  Created by Aaron Lee on 2017/08/27.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import UIKit

protocol PhotosViewRouter: ViewRouter {
    func presentDetailsView(for photo: Photo)
//    func presentAddBook(addBookPresenterDelegate: AddBookPresenterDelegate)
}

class PhotosViewRouterImplementation: PhotosViewRouter {
    fileprivate weak var photosCollectionViewController: PhotosCollectionViewController?
//    fileprivate weak var addBookPresenterDelegate: AddBookPresenterDelegate?
    fileprivate var photo: Photo!
    
    init(photosCollectionViewController: PhotosCollectionViewController) {
        self.photosCollectionViewController = photosCollectionViewController
    }
    
    // MARK: - BooksViewRouter
    
    func presentDetailsView(for photo: Photo) {
        self.photo = photo
        photosCollectionViewController?.performSegue(withIdentifier: "PhotosSceneToPhotoDetailsSceneSegue", sender: nil)
    }

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photoDetailsTableViewController = segue.destination as? PhotoDetailsTableViewController {
            photoDetailsTableViewController.configurator = PhotoDetailsConfiguratorImplementation(photo: photo)
        }
//        else if let navigationController = segue.destination as? UINavigationController,
//            let addBookViewController = navigationController.topViewController as? AddBookViewController {
//            addBookViewController.configurator = AddBookConfiguratorImplementation(addBookPresenterDelegate: addBookPresenterDelegate)
//        }
    }
    
}
