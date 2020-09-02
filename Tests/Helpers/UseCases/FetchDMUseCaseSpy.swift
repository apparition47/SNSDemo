
//
//  FetchDMUseCaseSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

@testable import SNS_Demo

class FetchDMUseCaseSpy: FetchDMUseCase {
    
    var resultToBeReturned: Result<[DM]>!
    
    func fetch(parameters: FetchDMParameters, completionHandler: @escaping FetchDMUseCaseCompletionHandler) {
        completionHandler(resultToBeReturned)
    }
}
