//
//  UIViewController-Alert.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

extension UIViewController {
	
	func presentAlert(withTitle title:String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
		
		present(alert, animated: true, completion: nil)
	}
	
}
