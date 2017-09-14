//
//  PhotoDetailsTableViewController.swift
//  Library
//
//  Created by Aaron Lee on 2017/09/02.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import UIKit

class PhotoDetailsTableViewController: UITableViewController {
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
	
	// MARK: - UIViewController
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configurator.configure(photoDetailsTableViewController: self)
		presenter.viewDidLoad()
        
        tableView.allowsSelection = false
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

}
