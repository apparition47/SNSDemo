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
    func displayError(title: String, message: String)
    func updateBackground(hexColour: String)
}

protocol FollowerCellView {
    func display(screenName: String)
}

protocol FollowersPresenter {
    var numberOfFollowers: Int { get }
    var router: FollowersViewRouter { get }
    func viewWillAppear()
    func configure(cell: FollowerTableViewCell, forRow row: Int)
    func didSelect(row: Int)
    func didSelectMyTimeline()
}

class FollowersPresenterImplementation: FollowersPresenter {
    fileprivate weak var view: FollowersView?
    fileprivate let loginUseCase: LoginUseCase
    fileprivate let fetchFollowersUseCase: FetchFollowersUseCase
    internal let router: FollowersViewRouter
    
    // Normally this would be file private as well, we keep it internal so we can inject values for testing purposes
    var timelines = [User]()
    
    var numberOfFollowers: Int {
        timelines.count
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
    
    func viewWillAppear() {
        self.timelines = []
        fetchFollowersUseCase.fetchFollowers { [weak self] result in
            switch result {
            case let .success(followers):
                self?.handleFollowersReceived(followers)
            case let .failure(error):
                self?.handleFollowersError(error)
            }
        }
    }
    
    func configure(cell: FollowerTableViewCell, forRow row: Int) {
        let timeline = timelines[row]
        
        cell.display(screenName: timeline.email)
    }
    
    func didSelect(row: Int) {
        let follower = timelines[row]
        
        router.presentDetailsView(for: follower)
    }

    func didSelectMyTimeline() {
        if let currentUser = loginUseCase.getMyAccount(completion: { _ in }) {
            router.presentDetailsView(for: currentUser)
        } else {
            view?.displayError(title: "Error", message: "Please login first")
        }
    }
    
    // MARK: - Private

    fileprivate func handleFollowersReceived(_ followers: [User]) {
        self.timelines += followers
        view?.refreshFollowersView()
    }
    
    fileprivate func handleFollowersError(_ error: Error) {
        view?.displayError(title: "Error", message: "Error fetching timelines")
    }
}
