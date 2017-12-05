//
//  ProjectDetailsTableViewController.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

final class ProjectDetailsTableViewController: UITableViewController {
	var presenter: ProjectDetailsPresenter!
	var configurator: ProjectDetailsConfigurator!
	
	// MARK: - IBOutlets
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dimensionsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var project: UIImageView!
    @IBOutlet weak var keywordsView: UICollectionView!
    
    
	// MARK: - UIViewController
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configurator.configure(projectDetailsTableViewController: self)
		presenter.viewDidLoad()
        
        tableView.allowsSelection = false
	}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    

}

// MARK: - UICollectionViewDataSource

extension ProjectDetailsTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return presenter.numberOfKeywords
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as ProjectKeywordCell

        return cell
    }
}

// MARK: - ProjectDetailsView

extension ProjectDetailsTableViewController: ProjectDetailsView {
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
    
    func display(largeProjectUrl: String) {
        project.loadImageUsingCache(withUrl: largeProjectUrl)
    }

    func refreshKeywordsView() {
        DispatchQueue.main.async {
            self.keywordsView.reloadData()
        }
    }
}
