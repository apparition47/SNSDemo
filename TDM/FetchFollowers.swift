//
//  FetchFollowers.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

typealias FetchFollowersUseCaseCompletionHandler = (_ followers: Result<[User]>) -> Void

//struct FetchFollowersParameters {
//    //    let query: String?
//    //    let page: Int?
//}

protocol FetchFollowersUseCase {
    func fetchFollowers(completionHandler: @escaping FetchFollowersUseCaseCompletionHandler)
}

class FetchFollowersUseCaseImplementation: FetchFollowersUseCase {
    
    let followersGateway: FollowersGateway
    
    init(followersGateway: FollowersGateway) {
        self.followersGateway = followersGateway
    }
    
    // MARK: - FetchFollowersUseCase
    
    func fetchFollowers(completionHandler: @escaping FetchFollowersUseCaseCompletionHandler) {
        followersGateway.fetchTimelines { result in
            completionHandler(result)
        }
    }
    
}
