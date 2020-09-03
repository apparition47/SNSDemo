//
//  DeleteDMUseCaseSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2020/09/02.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

@testable import SNS_Demo

class DeleteDMUseCaseSpy: DeleteDMUseCase {
    
    var dmToDelete: DM?
    var resultToBeReturned: Result<Void>!
    
    func delete(parameters: DeleteDMParameters, completionHandler: @escaping DeleteDMUseCaseCompletionHandler) {
        dmToDelete = DM(uid: parameters.uid, message: "", from: "")
        completionHandler(resultToBeReturned)
    }
}
