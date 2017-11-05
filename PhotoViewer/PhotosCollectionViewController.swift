//
//  PhotosCollectionViewController.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    var configurator = PhotosConfiguratorImplementation(query: "")
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
    @IBOutlet var searchBar: UISearchBar!
    
    
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
    
    // MARK: - UIScrollView
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // if at bottom
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            presenter.didScrollViewToBottom()
        }
    }
}

// MARK: - PhotosView

extension PhotosCollectionViewController: PhotosView {
    func updateTitleBar(givenTitle: String) {
        if !givenTitle.isEmpty {
            searchBar.isHidden = true
            // TODO fix viewcontroller titling
//            title = givenTitle
        }
    }
    
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
        if let query = searchBar.text {
            presenter.didSearch(query, clearOldResults: true)
        }
        searchBar.resignFirstResponder()
    }
}
