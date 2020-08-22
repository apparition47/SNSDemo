//
//  AccountConfigurator.swift
//  TDM
//
//  Created by Aaron Lee on 2020/08/22.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation

protocol AccountConfigurator {
    func configure(viewController: AccountViewController)
}

class AccountConfiguratorImplementation: AccountConfigurator {
    func configure(viewController: AccountViewController) {
        let apiClient = ApiClientImplementation()
        let apiFollowersGateway = ApiFollowersGatewayImplementation(apiClient: apiClient)
        
        let followersGateway = CacheFollowersGateway(apiFollowersGateway: apiFollowersGateway)
        
        
        let loginUseCase = LoginUseCaseImplementation(followersGateway: followersGateway)
        let updateTimelineUseCase = UpdateTimelineUseCaseImplementation(followersGateway: followersGateway)
        
        let presenter = AccountPresenterImplementation(
            view: viewController,
            loginUseCase: loginUseCase,
            updateTimelineUseCase: updateTimelineUseCase)
        
        viewController.presenter = presenter
    }
}
