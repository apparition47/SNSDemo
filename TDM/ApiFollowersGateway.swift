//
//  ApiFollowersGateway.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation


protocol ApiFollowersGateway: FollowersGateway {
    
}

class ApiFollowersGatewayImplementation: ApiFollowersGateway {

    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    // MARK: - ApiFollowersGateway
    
    func login(parameters: LoginParameters, completionHandler: @escaping LoginEntityGatewayCompletionHandler) {
        apiClient.login { result in
            completionHandler(result)
        }
    }
    
    func fetchFollowers(parameters: FetchFollowersParameters, completionHandler: @escaping FetchFollowersEntityGatewayCompletionHandler) {
        
        let followersApiRequest = GetFollowersApiRequest(getFollowersParameters: parameters)
        apiClient.execute(followersApiRequest) { (result: Result<GetFollowersApiRequest.ResponseType>) in
            switch result {
            case let .success(response):
                completionHandler(.success(response))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func postDM(parameters: PostDMParameters, completionHandler: @escaping PostDMEntityGatewayCompletionHandler) {
        // virtual network API call
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            // passthrough to simulate API response
            let dm = DM(message: parameters.message, isFromSelf: true)
            completionHandler(Result.success(dm))
        })
    }
    
    func fetchDM(parameters: FetchDMParameters, completionHandler: @escaping FetchDMEntityGatewayCompletionHandler) {
        // virtual network API call to get simulated messages
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            let result = parameters.dm.map { DM(message: "\($0.message) \($0.message)", isFromSelf: false) }
            completionHandler(Result.success(result))
        })
    }
}
