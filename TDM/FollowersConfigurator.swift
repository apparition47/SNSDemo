//
//  LoginConfigurator.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol FollowersConfigurator {
    func configure(followersViewController: FollowersViewController)
}

class FollowersConfiguratorImplementation: FollowersConfigurator {
    func configure(followersViewController: FollowersViewController) {
        let apiClient = ApiClientImplementation()
        let apiFollowersGateway = ApiFollowersGatewayImplementation(apiClient: apiClient)
        
        let followersGateway = CacheFollowersGateway(apiFollowersGateway: apiFollowersGateway)
        
        let loginUseCase = LoginUseCaseImplementation(followersGateway: followersGateway)
        let fetchFollowersUseCase = FetchFollowersUseCaseImplementation(followersGateway: followersGateway)
        
        let router = FollowersViewRouterImplementation(followersViewController: followersViewController)
        
        let presenter = FollowersPresenterImplementation(view: followersViewController,
                                                              loginUseCase: loginUseCase,
                                                              fetchFollowersUseCase: fetchFollowersUseCase,
                                                              router: router)
        
        followersViewController.presenter = presenter
    }
}
