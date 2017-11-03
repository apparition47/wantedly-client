//
//  UIViewController-Alert.swift
//  PhotoViewer
//
//  Created by Aaron Lee on 2017/11/03.
//  Copyright © 2017 One Fat Giraffe. All rights reserved.
//

import UIKit

extension UIViewController {
	
	func presentAlert(withTitle title:String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
		
		present(alert, animated: true, completion: nil)
	}
	
}
