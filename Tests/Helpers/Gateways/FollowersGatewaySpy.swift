//
//  FollowersGatewaySpy.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/21.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

@testable import SNS_Demo

class FollowersGatewaySpy: FollowersGateway {
    
    var myAccountResultToBeReturned: User?
    var loginResultToBeReturned: Result<User>!
    var registerResultToBeReturned: Result<User>!
    var logoutResultToBeReturned: Result<Void>!
    var fetchTimelineResultToBeReturned: Result<[User]>!
    var updateTimelineResultToBeReturned: Result<Void>!
    var postDMResultToBeReturned: Result<Void>!
    var fetchDMResultToBeReturned: Result<[DM]>!
    var deleteDMResultToBeReturned: Result<Void>!
    
    func getMyAccount(callback: @escaping (User?) -> ()) -> User? {
        myAccountResultToBeReturned
    }
    
    func login(parameters: LoginParameters, completionHandler: @escaping LoginEntityGatewayCompletionHandler) {
        completionHandler(loginResultToBeReturned)
    }
    
    func register(parameters: LoginParameters, completionHandler: @escaping RegisterEntityGatewayCompletionHandler) {
        completionHandler(registerResultToBeReturned)
    }
    
    func logout(completionHandler: @escaping LogoutEntityGatewayCompletionHandler) {
        completionHandler(logoutResultToBeReturned)
    }
    
    func fetchTimelines(completion: @escaping FetchTimelinesEntityGatewayCompletionHandler) {
        completion(fetchTimelineResultToBeReturned)
    }
    
    func updateTimeline(parameters: UpdateTimelineParameters, completionHandler: @escaping PostDMEntityGatewayCompletionHandler) {
        completionHandler(updateTimelineResultToBeReturned)
    }
    
    func postDM(parameters: PostDMParameters, completionHandler: @escaping PostDMEntityGatewayCompletionHandler) {
        completionHandler(postDMResultToBeReturned)
    }
    
    func fetchDM(parameters: FetchDMParameters, completionHandler: @escaping FetchDMEntityGatewayCompletionHandler) {
        completionHandler(fetchDMResultToBeReturned)
    }
    
    func deleteDM(parameters: DeleteDMParameters, completionHandler: @escaping DeleteDMEntityGatewayCompletionHandler) {
        completionHandler(deleteDMResultToBeReturned)
    }
}
