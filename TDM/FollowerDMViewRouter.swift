//
//  FollowerDMViewRouter.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/07.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

protocol FollowerDMViewRouter: ViewRouter {
	func dismissView()
}

class FollowerDMViewRouterImplementation: FollowerDMViewRouter {
	fileprivate weak var followerDMViewController: FollowerDMViewController?
	
	init(followerDMViewController: FollowerDMViewController) {
		self.followerDMViewController = followerDMViewController
	}
	
	// MARK: - FollowerDMViewRouter
	
    func dismissView() {
        let _ = followerDMViewController?.navigationController?.popViewController(animated: true)
    }
	
}
