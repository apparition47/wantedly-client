//
//  PhotoCollectionViewCell.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell, PhotoCellView {
    
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var thumbnailView: UIImageView!
	
	func display(createdAt: String) {
		createdAtLabel.text = createdAt
	}
	
	func display(username: String) {
		usernameLabel.text = username
	}
	
	func display(thumbnailUrl: String) {
		thumbnailView.loadImageUsingCache(withUrl: thumbnailUrl)
        
        thumbnailView.layer.shadowColor = UIColor.black.cgColor
        thumbnailView.layer.shadowOpacity = 0.7
        thumbnailView.layer.shadowOffset = CGSize.zero
        thumbnailView.layer.shadowRadius = 3
	}
	
}
