//
//  PhotosCollectionViewController.swift
//  Library
//
//  Created by Aaron Lee on 2017/08/27.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    var configurator = PhotosConfiguratorImplementation()
    var presenter: PhotosPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(photosCollectionViewController: self)
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    // MARK: - IBAction
    
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfPhotos
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
}

// MARK: - PhotosView

extension PhotosCollectionViewController: PhotosView {
    func refreshPhotosView() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func displayPhotosRetrievalError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }

}

// MARK: - Search

extension PhotosCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.didSearch(query: searchBar.text!)
        searchBar.resignFirstResponder()
    }
}
