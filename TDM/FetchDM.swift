//
//  FetchDM.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/07.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

typealias FetchDMUseCaseCompletionHandler = (_ followers: Result<[DM]>) -> Void

struct FetchDMParameters {
    let dm: [DM] // fake passthrough
}

protocol FetchDMUseCase {
    func fetch(parameters: FetchDMParameters, completionHandler: @escaping FetchDMUseCaseCompletionHandler)
}

class FetchDMUseCaseImplementation: FetchDMUseCase {
    
    let followersGateway: FollowersGateway
    
    init(followersGateway: FollowersGateway) {
        self.followersGateway = followersGateway
    }
    
    // MARK: - FetchFollowersUseCase
    
    func fetch(parameters: FetchDMParameters, completionHandler: @escaping FetchDMUseCaseCompletionHandler) {
        self.followersGateway.fetchDM(parameters: parameters) { result in
            completionHandler(result)
        }
    }
    
}
