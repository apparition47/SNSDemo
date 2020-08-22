//
//  DeleteDM.swift
//  TDM
//
//  Created by Aaron Lee on 2020/08/21.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation

typealias DeleteDMUseCaseCompletionHandler = (_ followers: Result<Void>) -> Void

struct DeleteDMParameters {
    let email: String
    let uid: String
}

protocol DeleteDMUseCase {
    func delete(parameters: DeleteDMParameters, completionHandler: @escaping DeleteDMUseCaseCompletionHandler)
}

class DeleteDMUseCaseImplementation: DeleteDMUseCase {
    
    let followersGateway: FollowersGateway
    
    init(followersGateway: FollowersGateway) {
        self.followersGateway = followersGateway
    }
    
    // MARK: - DeleteDMUseCase
    
    func delete(parameters: DeleteDMParameters, completionHandler: @escaping DeleteDMUseCaseCompletionHandler) {
        guard let user = self.followersGateway.getMyAccount(callback: { _ in }), user.email == parameters.email else {
            completionHandler(.failure(NSError(domain: "", code: 999, userInfo: [NSLocalizedDescriptionKey: "Can't delete your own post"])))
            return
        }
        
        self.followersGateway.deleteDM(parameters: parameters) { result in
            switch result {
            case .success():
                completionHandler(result)
            case .failure(_):
                completionHandler(result)
            }
        }
    }
    
}
