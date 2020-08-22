//
//  FollowersGateway.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

typealias LoginEntityGatewayCompletionHandler = (_ followers: Result<User>) -> Void
typealias RegisterEntityGatewayCompletionHandler = (_ followers: Result<User>) -> Void
typealias LogoutEntityGatewayCompletionHandler = (_ followers: Result<Void>) -> Void

typealias FetchTimelinesEntityGatewayCompletionHandler = (_ users: Result<[User]>) -> Void
typealias PostDMEntityGatewayCompletionHandler = (_ followers: Result<Void>) -> Void
typealias FetchDMEntityGatewayCompletionHandler = (_ followers: Result<[DM]>) -> Void
typealias DeleteDMEntityGatewayCompletionHandler = (_ followers: Result<Void>) -> Void

protocol FollowersGateway {
    func getMyAccount(callback: @escaping (User?) -> ()) -> User?
    func login(parameters: LoginParameters, completionHandler: @escaping LoginEntityGatewayCompletionHandler)
    func register(parameters: LoginParameters, completionHandler: @escaping RegisterEntityGatewayCompletionHandler)
    func logout(completionHandler: @escaping LogoutEntityGatewayCompletionHandler)
    
    func fetchTimelines(completion: @escaping FetchTimelinesEntityGatewayCompletionHandler)
    func updateTimeline(parameters: UpdateTimelineParameters, completionHandler: @escaping PostDMEntityGatewayCompletionHandler)
    
    func postDM(parameters: PostDMParameters, completionHandler: @escaping PostDMEntityGatewayCompletionHandler)
    func fetchDM(parameters: FetchDMParameters, completionHandler: @escaping FetchDMEntityGatewayCompletionHandler)
    func deleteDM(parameters: DeleteDMParameters, completionHandler: @escaping DeleteDMEntityGatewayCompletionHandler)
}
