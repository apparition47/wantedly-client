//
//  ProjectKeywordCell.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/11/05.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit
import Reusable

final class ProjectKeywordCell: UICollectionViewCell, ProjectKeywordView, Reusable {
    
    @IBOutlet weak var keywordButton: UILabel!
    
    func display(keyword: String) {
        keywordButton.text = keyword
    }
    
}

