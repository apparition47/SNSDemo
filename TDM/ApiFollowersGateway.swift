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
    
    func register(parameters: LoginParameters, completionHandler: @escaping RegisterEntityGatewayCompletionHandler) {
        apiClient.signup(email: parameters.email, password: parameters.password) { result in
            switch result {
            case let .success(response):
                completionHandler(.success(response))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func logout(completionHandler: @escaping LogoutEntityGatewayCompletionHandler) {
        apiClient.logout { result in
            switch result {
            case let .success(response):
                completionHandler(.success(response))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func login(parameters: LoginParameters, completionHandler: @escaping LoginEntityGatewayCompletionHandler) {
        apiClient.login(email: parameters.email, password: parameters.password) { result in
            switch result {
            case let .success(response):
                completionHandler(.success(response))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchTimelines(completion: @escaping FetchTimelinesEntityGatewayCompletionHandler) {
        let followersApiRequest = GetFollowersApiRequest()
        apiClient.execute(followersApiRequest) { (result: Result<GetFollowersApiRequest.ResponseType>) in
            switch result {
            case let .success(response):
                let payload = response.map { User(email: $0.email) }
                completion(.success(payload))
            case let .failure(error):
                completion(.failure(error))
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
    
    func deleteDM(parameters: DeleteDMParameters, completionHandler: @escaping DeleteDMEntityGatewayCompletionHandler) {
        let apiRequest = DeletePostApiRequest(email: parameters.email, uid: parameters.uid)
        apiClient.execute(apiRequest) { (result: Result<DeletePostApiRequest.ResponseType>) in
            switch result {
            case .success:
                completionHandler(result)
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}
