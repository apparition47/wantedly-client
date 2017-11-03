//
//  ViewRouter.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import UIKit

protocol ViewRouter {
	func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

extension ViewRouter {
	func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
}
