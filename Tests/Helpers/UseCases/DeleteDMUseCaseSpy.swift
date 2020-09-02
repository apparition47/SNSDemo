//
//  DeleteDMUseCaseSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2020/09/02.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

@testable import SNS_Demo

class DeleteDMUseCaseSpy: DeleteDMUseCase {
    
    var resultToBeReturned: Result<Void>!
    
    func delete(parameters: DeleteDMParameters, completionHandler: @escaping DeleteDMUseCaseCompletionHandler) {
        completionHandler(resultToBeReturned)
    }
}
