//
//  PostDMUseCaseSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2020/09/02.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

@testable import SNS_Demo

class PostDMUseCaseSpy: PostDMUseCase {

    var resultToBeReturned: Result<Void>!
    
    func post(parameters: PostDMParameters, completionHandler: @escaping PostDMUseCaseCompletionHandler) {
        completionHandler(resultToBeReturned)
    }
}
