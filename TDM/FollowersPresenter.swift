//
//  LoginPresenter.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol FollowersView: class {
    func refreshFollowersView()
    func displayFollowersRetrievalError(title: String, message: String)
    func updateBackground(hexColour: String)
}

protocol FollowerCellView {
    func display(screenName: String)
}

protocol FollowersPresenter {
    var numberOfFollowers: Int { get }
    var router: FollowersViewRouter { get }
//    func viewDidLoad()
    func configure(cell: FollowerTableViewCell, forRow row: Int)
    func didSelect(row: Int)
}

class FollowersPresenterImplementation: FollowersPresenter {
    fileprivate weak var view: FollowersView?
    fileprivate let loginUseCase: LoginUseCase
    fileprivate let fetchFollowersUseCase: FetchFollowersUseCase
    internal let router: FollowersViewRouter
    
    // Normally this would be file private as well, we keep it internal so we can inject values for testing purposes
    var followers = [Follower]()
    
    var numberOfFollowers: Int {
        return followers.count
    }
    
    init(view: FollowersView,
         loginUseCase: LoginUseCase,
         fetchFollowersUseCase: FetchFollowersUseCase,
         router: FollowersViewRouter) {
        self.view = view
        self.loginUseCase = loginUseCase
        self.fetchFollowersUseCase = fetchFollowersUseCase
        self.router = router
    }
    
    
    // MARK: - FollowersPresenter
    
//    func viewDidLoad() {
//        doLoginFlow()
//    }
    
    func configure(cell: FollowerTableViewCell, forRow row: Int) {
        let follower = followers[row]

        cell.display(screenName: "@\(follower.screen_name)")
    }
    
    func didSelect(row: Int) {
        let follower = followers[row]
        
        router.presentDetailsView(for: follower)
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
    
    fileprivate func handleFollowersReceived(_ followers: [Follower]) {
        self.followers += followers
        view?.refreshFollowersView()
    }
    
    fileprivate func handleFollowersError(_ error: Error) {
        view?.displayFollowersRetrievalError(title: "Error", message: error.localizedDescription)
    }
}
