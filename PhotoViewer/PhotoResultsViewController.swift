//
//  PhotoResultsViewController.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

final class PhotoResultsViewController: UICollectionViewController {
    var configurator = PhotoResultsConfiguratorImplementation(query: "")
    var presenter: PhotoResultsPresenter!
    var notificationFeedbackGenerator: UINotificationFeedbackGenerator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(photoResultsViewController: self)
        presenter.viewDidLoad()
        
        notificationFeedbackGenerator = UINotificationFeedbackGenerator()
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
        let cell = collectionView.dequeueReusableCell(for: indexPath) as PhotoCollectionViewCell
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
            notificationFeedbackGenerator?.prepare()
            presenter.didScrollViewToBottom()
        }
    }
}

// MARK: - PhotosView

extension PhotoResultsViewController: PhotosView {
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
        notificationFeedbackGenerator?.notificationOccurred(.error)
    }

}

// MARK: - Search

extension PhotoResultsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            presenter.didSearch(query, clearOldResults: true)
        }
        searchBar.resignFirstResponder()
    }
}
