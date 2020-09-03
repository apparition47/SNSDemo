//
//  PostDM.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

typealias PostDMUseCaseCompletionHandler = (_ followers: Result<Void>) -> Void

// for echo simulation
struct PostDMUseCaseNotifications {
    static let didPostDM = Notification.Name("didPostDM")
}

struct PostDMParameters {
    let message: String
    let timelineEmail: String
    let fromEmail: String
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
        followersGateway.postDM(parameters: parameters) { result in
            switch result {
            case .success(_):
                completionHandler(result)
            case .failure(_):
                completionHandler(result)
            }
        }
    }
}
