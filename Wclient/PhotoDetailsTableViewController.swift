//
//  PhotoDetailsTableViewController.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

final class PhotoDetailsTableViewController: UITableViewController {
	var presenter: PhotoDetailsPresenter!
	var configurator: PhotoDetailsConfigurator!
	
	// MARK: - IBOutlets
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dimensionsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var keywordsView: UICollectionView!
    
    
	// MARK: - UIViewController
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configurator.configure(photoDetailsTableViewController: self)
		presenter.viewDidLoad()
        
        tableView.allowsSelection = false
	}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    

}

// MARK: - UICollectionViewDataSource

extension PhotoDetailsTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfKeywords
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as PhotoKeywordCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        
        // pulse to indicate it's interactable
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: [], animations: {
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: [], animations: {
                cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
}

// MARK: - PhotoDetailsView

extension PhotoDetailsTableViewController: PhotoDetailsView {
    func display(createdAt: String) {
        createdAtLabel.text = createdAt
    }
    
    func display(updatedAt: String) {
        updatedAtLabel.text = updatedAt
    }
    
    func display(dimensions: String) {
        dimensionsLabel.text = dimensions
    }
    
    func display(likes: String) {
        likesLabel.text = likes
    }
    
    func display(description: String) {
        descriptionLabel.text = description
    }
    
    func display(username: String) {
        usernameLabel.text = username
    }
    
    func display(largePhotoUrl: String) {
        photo.loadImageUsingCache(withUrl: largePhotoUrl)
    }

//    func display(dominantObject: String) {
//        dominantObjectLabel.text = dominantObject
//    }
    
    func refreshKeywordsView() {
        DispatchQueue.main.async {
            self.keywordsView.reloadData()
        }
    }
}
