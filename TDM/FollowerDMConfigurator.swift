//
//  FollowerDMConfigurator.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol FollowerDMConfigurator {
    func configure(followerDMViewController: FollowerDMViewController)
}

class FollowerDMConfiguratorImplementation: FollowerDMConfigurator {
    
    let follower: Follower
    
    init(follower: Follower) {
        self.follower = follower
    }
    
    func configure(followerDMViewController: FollowerDMViewController) {
        let apiClient = ApiClientImplementation()
        let apiFollowersGateway = ApiFollowersGatewayImplementation(apiClient: apiClient)
        
        let followersGateway = CacheFollowersGateway(apiFollowersGateway: apiFollowersGateway)
        
        let postDMUseCase = PostDMUseCaseImplementation(followersGateway: followersGateway)
        let fetchDMUseCase = FetchDMUseCaseImplementation(followersGateway: followersGateway)
        
        let router = FollowerDMViewRouterImplementation(followerDMViewController: followerDMViewController)
        
        let presenter = FollowerDMPresenterImplementation(view: followerDMViewController,
                                                          follower: follower,
                                                         postDMUseCase: postDMUseCase,
                                                         fetchDMUseCase: fetchDMUseCase,
                                                         router: router)
        
        followerDMViewController.presenter = presenter
    }
}

