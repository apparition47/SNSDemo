//
//  UpdateTimeline.swift
//  TDM
//
//  Created by Aaron Lee on 2020/08/22.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation


typealias UpdateTimelineUseCaseCompletionHandler = (_ followers: Result<Void>) -> Void

struct UpdateTimelineParameters {
    let email: String
}

protocol UpdateTimelineUseCase {
    func updateTimeline(parameters: UpdateTimelineParameters, completionHandler: @escaping UpdateTimelineUseCaseCompletionHandler)
}

class UpdateTimelineUseCaseImplementation: UpdateTimelineUseCase {
    
    let followersGateway: FollowersGateway
    
    init(followersGateway: FollowersGateway) {
        self.followersGateway = followersGateway
    }
    
    // MARK: - UpdateTimelineUseCase
    
    func updateTimeline(parameters: UpdateTimelineParameters, completionHandler: @escaping UpdateTimelineUseCaseCompletionHandler) {
        followersGateway.updateTimeline(parameters: parameters) { result in
            switch result {
            case .success(_):
                completionHandler(result)
            case .failure(_):
                completionHandler(result)
            }
        }
    }
    
}
