//
//  CacheFollowersGateway.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

class CacheFollowersGateway: FollowersGateway {

    let apiFollowersGateway: ApiFollowersGateway

    init(apiFollowersGateway: ApiFollowersGateway) {
        self.apiFollowersGateway = apiFollowersGateway
    }
    
    // MARK: - FollowersGateway

    func login(parameters: LoginParameters, completionHandler: @escaping LoginEntityGatewayCompletionHandler) {
        apiFollowersGateway.login(parameters: parameters) { result in
            self.handleLoginApiResult(result, parameters: parameters, completionHandler: completionHandler)
        }
    }
    
    func fetchFollowers(parameters: FetchFollowersParameters, completionHandler: @escaping FetchFollowersEntityGatewayCompletionHandler) {
        // TODO write to CoreData
        apiFollowersGateway.fetchFollowers(parameters: parameters) { result in
            self.handleGetFollowersApiResult(result, parameters: parameters, completionHandler: completionHandler)
        }
    }
    
    func postDM(parameters: PostDMParameters, completionHandler: @escaping PostDMEntityGatewayCompletionHandler) {
        // TODO write to CoreData
        apiFollowersGateway.postDM(parameters: parameters) { result in
            self.handlePostDMApiResult(result, parameters: parameters, completionHandler: completionHandler)
        }
    }
    
    func fetchDM(parameters: FetchDMParameters, completionHandler: @escaping FetchDMEntityGatewayCompletionHandler) {
        // TODO write to CoreData
        apiFollowersGateway.fetchDM(parameters: parameters) { result in
            self.handleFetchDMApiResult(result, parameters: parameters, completionHandler: completionHandler)
        }
    }
    
    
    // MARK: - Private

    fileprivate func handleLoginApiResult(_ result: Result<Void>, parameters: LoginParameters, completionHandler: LoginEntityGatewayCompletionHandler) {
        switch result {
        case .success(_):
            completionHandler(result)
        case .failure(_):
            completionHandler(result)
        }
    }
    
    fileprivate func handleGetFollowersApiResult(_ result: Result<[Follower]>, parameters: FetchFollowersParameters, completionHandler: FetchFollowersEntityGatewayCompletionHandler) {
        switch result {
        case .success(_):
            completionHandler(result)
        case .failure(_):
            completionHandler(result)
        }
    }
    
    fileprivate func handlePostDMApiResult(_ result: Result<DM>, parameters: PostDMParameters, completionHandler: PostDMEntityGatewayCompletionHandler) {
        switch result {
        case let .success(dm):
            completionHandler(.success(dm))
        case .failure(_):
            completionHandler(result)
        }
    }
    
    fileprivate func handleFetchDMApiResult(_ result: Result<[DM]>, parameters: FetchDMParameters, completionHandler: FetchDMEntityGatewayCompletionHandler) {
        switch result {
        case .success(_):
            completionHandler(result)
        case .failure(_):
            completionHandler(result)
        }
    }
    
}
