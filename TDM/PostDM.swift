//
//  PostDM.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

typealias PostDMUseCaseCompletionHandler = (_ followers: Result<DM>) -> Void

// for echo simulation
struct PostDMUseCaseNotifications {
    static let didPostDM = Notification.Name("didPostDM")
}

struct PostDMParameters {
    let message: String
}

protocol PostDMUseCase {
    func post(parameters: PostDMParameters, completionHandler: @escaping PostDMUseCaseCompletionHandler)
}

class PostDMUseCaseImplementation: PostDMUseCase {
    
    let followersGateway: FollowersGateway
    
    init(followersGateway: FollowersGateway) {
        self.followersGateway = followersGateway
    }
    
    // MARK: - PostDMUseCase
    
    func post(parameters: PostDMParameters, completionHandler: @escaping PostDMUseCaseCompletionHandler) {
        self.followersGateway.postDM(parameters: parameters) { result in
            switch result {
            case let .success(dm):
                // post NSNotification to simulate received message over network
                NotificationCenter.default.post(name: PostDMUseCaseNotifications.didPostDM, object: dm)
                completionHandler(result)
            case .failure(_):
                completionHandler(result)
            }
        }
    }
    
}
