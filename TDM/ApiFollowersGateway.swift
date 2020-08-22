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
    
    func getMyAccount(callback: @escaping (User?) -> ()) -> User? {
        apiClient.didUserStateChange { user in
            callback(user)
        }
        return apiClient.currentUser
    }
    
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
    
    func updateTimeline(parameters: UpdateTimelineParameters, completionHandler: @escaping PostDMEntityGatewayCompletionHandler) {
        let apiRequest = UpdateTimelineApiRequest(email: parameters.email)
        apiClient.execute(apiRequest) { (result: Result<PostDMApiRequest.ResponseType>) in
            switch result {
            case .success:
                completionHandler(.success( () ))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func postDM(parameters: PostDMParameters, completionHandler: @escaping PostDMEntityGatewayCompletionHandler) {
        let apiRequest = PostDMApiRequest(email: parameters.email ?? "", uid: UUID().uuidString, message: parameters.message)
        apiClient.execute(apiRequest) { (result: Result<PostDMApiRequest.ResponseType>) in
            switch result {
            case .success:
                completionHandler(.success( () ))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchDM(parameters: FetchDMParameters, completionHandler: @escaping FetchDMEntityGatewayCompletionHandler) {
        let apiRequest = FetchTimelineApiRequest(email: parameters.email)
        apiClient.execute(apiRequest) { (result: Result<FetchTimelineApiRequest.ResponseType>) in
            switch result {
            case .success:
                completionHandler(result)
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func deleteDM(parameters: DeleteDMParameters, completionHandler: @escaping DeleteDMEntityGatewayCompletionHandler) {
        let apiRequest = DeletePostApiRequest(email: parameters.email, uid: parameters.uid)
        apiClient.execute(apiRequest) { (result: Result<DeletePostApiRequest.ResponseType>) in
            switch result {
            case .success:
                completionHandler(.success( () ))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}
