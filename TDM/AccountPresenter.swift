//
//  AccountPresenter.swift
//  TDM
//
//  Created by Aaron Lee on 2020/08/22.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation

protocol AccountView: class {
    func displayLoggedIn(email: String)
    func displayLoggedOut()
    func displayError(msg: String)
}

protocol AccountPresenter {
    var numberOfFollowers: Int { get }
    func viewDidLoad()
    func configure(cell: FollowerTableViewCell, forRow row: Int)
    func loginPressed(email: String, password: String)
    func logoutPressed()
    func registerPressed(email: String, password: String)
}

class AccountPresenterImplementation: AccountPresenter {
    fileprivate weak var view: AccountView?
    fileprivate let loginUseCase: LoginUseCase
    fileprivate let updateTimelineUseCase: UpdateTimelineUseCase
    
    // Normally this would be file private as well, we keep it internal so we can inject values for testing purposes
    var timelines = [User]()
    
    var numberOfFollowers: Int {
        timelines.count
    }
    
    init(view: AccountView,
         loginUseCase: LoginUseCase,
         updateTimelineUseCase: UpdateTimelineUseCase) {
        self.view = view
        self.loginUseCase = loginUseCase
        self.updateTimelineUseCase = updateTimelineUseCase
    }
    
    
    // MARK: - FollowersPresenter
    
    func viewDidLoad() {
        if let user = loginUseCase.getMyAccount(completion: { [weak self] user in
            if let user = user {
                self?.view?.displayLoggedIn(email: user.email)
            }
        }) {
            view?.displayLoggedIn(email: user.email)
        }
    }
    
    func configure(cell: FollowerTableViewCell, forRow row: Int) {
        let timeline = timelines[row]
        
        cell.display(screenName: timeline.email)
    }
    
    func loginPressed(email: String, password: String) {
        let params = LoginParameters(email: email, password: password)
        loginUseCase.login(parameters: params) { [weak self] result in
            switch result {
            case let .success(user):
                self?.updateTimelineUseCase.updateTimeline(parameters: UpdateTimelineParameters(email: user.email)) { _ in }
                self?.view?.displayLoggedIn(email: user.email)
            case .failure:
                self?.view?.displayError(msg: "Failed to login")
            }
        }
    }
    
    func logoutPressed() {
        loginUseCase.logout { [weak self] result in
            switch result {
            case .success:
                self?.view?.displayLoggedOut()
            case .failure:
                self?.view?.displayError(msg: "Failed to logout")
            }
        }
    }
    
    func registerPressed(email: String, password: String) {
        let params = LoginParameters(email: email, password: password)
        loginUseCase.register(parameters: params) { [weak self] result in
            switch result {
            case let .success(user):
                self?.updateTimelineUseCase.updateTimeline(parameters: UpdateTimelineParameters(email: user.email)) { _ in }
                self?.view?.displayLoggedIn(email: user.email)
            case .failure:
                self?.view?.displayError(msg: "Failed to register")
            }
        }
    }
    

    // MARK: - Private

//    private func doLoginFlow() {
//        let params: LoginParameters = LoginParameters()
//
//        loginUseCase.login(parameters: params) { result in
//            switch result {
//            case .success(_):
//                self.handleLoginCompleted()
//            case let .failure(error):
//                self.handleFollowersError(error)
//            }
//        }
//    }

    fileprivate func handleLoginCompleted() {
//        let params = FetchFollowersParameters()
//        fetchFollowersUseCase.fetchFollowers(parameters: params) { result in
//            switch result {
//            case let .success(followers):
//                self.handleFollowersReceived(followers)
//            case let .failure(error):
//                self.handleFollowersError(error)
//            }
//        }
    }
    
}
