//
//  LoginUseCaseSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2020/09/02.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

@testable import SNS_Demo

class LoginUseCaseSpy: LoginUseCase {
    var getAccountResultToBeReturned: User?
    var loginResultToBeReturned: Result<User>!
    var registerResultToBeReturned: Result<User>!
    var logoutResultToBeReturned: Result<Void>!
    
    func getMyAccount(completion: @escaping GetMyAccountUseCaseCompletionHandler) -> User? {
        getAccountResultToBeReturned
    }
    
    func login(parameters: LoginParameters, completionHandler: @escaping LoginUseCaseCompletionHandler) {
        completionHandler(loginResultToBeReturned)
    }
    
    func register(parameters: LoginParameters, completionHandler: @escaping LoginUseCaseCompletionHandler) {
        completionHandler(registerResultToBeReturned)
    }
    
    func logout(completionHandler: @escaping LogoutUseCaseCompletionHandler) {
        completionHandler(logoutResultToBeReturned)
    }
    
}
