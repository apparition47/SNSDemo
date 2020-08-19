//
//  LoginViewRouter.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import UIKit

protocol FollowersViewRouter: ViewRouter {
    func presentDetailsView(for follower: Follower)
}

class FollowersViewRouterImplementation: FollowersViewRouter {

    struct Segue {
        static let FollowersSceneToFollowerDMSceneSegue = "FollowersSceneToFollowerDMSceneSegue"
    }
    
    fileprivate weak var followersViewController: FollowersViewController?
    fileprivate var follower: Follower!
    
    init(followersViewController: FollowersViewController) {
        self.followersViewController = followersViewController
    }
    
    // MARK: - LoginViewRouter
    
    func presentDetailsView(for follower: Follower) {
        self.follower = follower
        followersViewController?.performSegue(withIdentifier: Segue.FollowersSceneToFollowerDMSceneSegue, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let followerDMViewController = segue.destination as? FollowerDMViewController {
            followerDMViewController.configurator = FollowerDMConfiguratorImplementation(follower: follower)
        }
    }
    
}

