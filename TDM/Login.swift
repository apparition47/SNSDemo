//
//  Login.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

typealias GetMyAccountUseCaseCompletionHandler = (User?) -> Void
typealias LoginUseCaseCompletionHandler = (_ session: Result<User>) -> Void
typealias LogoutUseCaseCompletionHandler = (_ session: Result<Void>) -> Void

struct LoginParameters {
    let email: String
    let password: String
}

protocol LoginUseCase {
    func getMyAccount(completion: @escaping GetMyAccountUseCaseCompletionHandler) -> User?
    func login(parameters: LoginParameters, completionHandler: @escaping LoginUseCaseCompletionHandler)
    func register(parameters: LoginParameters, completionHandler: @escaping LoginUseCaseCompletionHandler)
    func logout(completionHandler: @escaping LogoutUseCaseCompletionHandler)
}

class LoginUseCaseImplementation: LoginUseCase {

    let followersGateway: FollowersGateway
    
    init(followersGateway: FollowersGateway) {
        self.followersGateway = followersGateway
    }
    
    // MARK: - LoginUseCase
    
    func getMyAccount(completion: @escaping GetMyAccountUseCaseCompletionHandler) -> User? {
        return self.followersGateway.getMyAccount(callback: completion)
    }
    
    func login(parameters: LoginParameters, completionHandler: @escaping LoginUseCaseCompletionHandler) {
        self.followersGateway.login(parameters: parameters) { result in
            completionHandler(result)
        }
    }

    func register(parameters: LoginParameters, completionHandler: @escaping LoginUseCaseCompletionHandler) {
        self.followersGateway.register(parameters: parameters) { result in
            completionHandler(result)
        }
    }
    
    func logout(completionHandler: @escaping LogoutUseCaseCompletionHandler) {
        self.followersGateway.logout { result in
            completionHandler(result)
        }
    }
    
}

