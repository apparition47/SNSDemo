//
//  FollowersGateway.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

typealias LoginEntityGatewayCompletionHandler = (_ followers: Result<Void>) -> Void
typealias FetchFollowersEntityGatewayCompletionHandler = (_ followers: Result<[Follower]>) -> Void
typealias PostDMEntityGatewayCompletionHandler = (_ followers: Result<DM>) -> Void
typealias FetchDMEntityGatewayCompletionHandler = (_ followers: Result<[DM]>) -> Void

protocol FollowersGateway {
    func login(parameters: LoginParameters, completionHandler: @escaping LoginEntityGatewayCompletionHandler)
    func fetchFollowers(parameters: FetchFollowersParameters, completionHandler: @escaping FetchFollowersEntityGatewayCompletionHandler)
    func postDM(parameters: PostDMParameters, completionHandler: @escaping PostDMEntityGatewayCompletionHandler)
    func fetchDM(parameters: FetchDMParameters, completionHandler: @escaping FetchDMEntityGatewayCompletionHandler)
}
