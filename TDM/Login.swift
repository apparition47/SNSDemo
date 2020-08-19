//
//  Login.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

typealias LoginUseCaseCompletionHandler = (_ session: Result<Void>) -> Void

struct LoginParameters {
//    let query: String?
//    let page: Int?
}

protocol LoginUseCase {
    func login(parameters: LoginParameters, completionHandler: @escaping LoginUseCaseCompletionHandler)
}

class LoginUseCaseImplementation: LoginUseCase {

    
    
    let followersGateway: FollowersGateway
    
    init(followersGateway: FollowersGateway) {
        self.followersGateway = followersGateway
    }
    
    // MARK: - LoginUseCase
    
    func login(parameters: LoginParameters, completionHandler: @escaping LoginUseCaseCompletionHandler) {
        self.followersGateway.login(parameters: parameters) { result in
            completionHandler(result)
        }
    }

}
