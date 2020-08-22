//
//  FollowerDMPresenter.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/07.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol FollowerDMView: class {
    func refreshFollowerDMView()
	func displayFollowerDMRetrievalError(title: String, message: String)
    func displayDMPostError(title: String, message: String)
    func updateHeaderTitle(_ title: String)
    func clearInput()
    func removePostCell(row: Int)
}

protocol BubbleCellView {
    func display(message: String)
}

protocol FollowerDMPresenter {
	var numberOfFollowerDM: Int { get }
	var router: FollowerDMViewRouter { get }
	func viewDidLoad()
	func configure(cell: BubbleCellView, forRow row: Int)
    func cellReuseIdType(forRow row: Int) -> String
    func textInputEditingChanged(to: String)
    func postButtonPressed()
    func deletePost(row: Int)
}

class FollowerDMPresenterImplementation: FollowerDMPresenter {

    fileprivate var inputMessage = ""
    fileprivate let follower: User
	fileprivate weak var view: FollowerDMView?
    private let loginUseCase: LoginUseCase
	fileprivate let postDMUseCase: PostDMUseCase
	fileprivate let fetchDMUseCase: FetchDMUseCase
    fileprivate let deleteDMUseCase: DeleteDMUseCase
	internal let router: FollowerDMViewRouter
	
	var followerDMs = [DM]()
	
	var numberOfFollowerDM: Int {
		return followerDMs.count
	}
	
	init(view: FollowerDMView,
         follower: User,
         loginUseCase: LoginUseCase,
	     postDMUseCase: PostDMUseCase,
	     fetchDMUseCase: FetchDMUseCase,
         deleteDMUseCase: DeleteDMUseCase,
	     router: FollowerDMViewRouter) {
		self.view = view
        self.follower = follower
        self.loginUseCase = loginUseCase
		self.postDMUseCase = postDMUseCase
		self.fetchDMUseCase = fetchDMUseCase
        self.deleteDMUseCase = deleteDMUseCase
		self.router = router
	}

	// MARK: - FollowerDMPresenter
	
	func viewDidLoad() {
        view?.updateHeaderTitle(follower.email)
        
        refreshDMs()
	}
	
	func configure(cell: BubbleCellView, forRow row: Int) {
		let dm = followerDMs[row]
		
        cell.display(message: dm.message)
	}
	
    func cellReuseIdType(forRow row: Int) -> String {
        let dm = followerDMs[row]
        return dm.isFromSelf ? BubbleTableViewCell.rightReuseableId : BubbleTableViewCell.leftReuseableId
    }
	
    func postButtonPressed() {
        if inputMessage.isEmpty {
            return
        }
        
        guard let myUser = loginUseCase.getMyAccount(completion: { _ in }) else {
            view?.displayDMPostError(title: "Error", message: "Please login first")
            return
        }
        
        let params = PostDMParameters(message: inputMessage.trimmingCharacters(in: .whitespacesAndNewlines), timelineEmail: follower.email, fromEmail: myUser.email)
        postDMUseCase.post(parameters: params) { [weak self] result in
            switch result {
            case .success:
                self?.refreshDMs()
            case let .failure(error):
                self?.handleDMPostError(error)
            }
        }
        view?.clearInput()
    }
    
    func textInputEditingChanged(to text: String) {
        inputMessage = text
    }
    
    func deletePost(row: Int) {
        let post = followerDMs[row]
        let params = DeleteDMParameters(timelineEmail: follower.email, fromEmail: post.from, uid: post.uid)
        deleteDMUseCase.delete(parameters: params) { [weak self] result in
            switch result {
            case .success:
                self?.followerDMs.remove(at: row)
                self?.view?.removePostCell(row: row)
            case let .failure(error):
                self?.handleDMPostError(error)
            }
        }
    }
	
	// MARK: - Private
	
    private func refreshDMs() {
        followerDMs = []
        let params = FetchDMParameters(email: follower.email)
        fetchDMUseCase.fetch(parameters: params) { [weak self] result in
            switch result {
            case let .success(dms):
                dms.forEach { self?.handleDMPosted(dm: $0) }
            
            default: break
            }
        }
    }
    
	fileprivate func handleFollowerDMError(_ error: Error) {
		// Here we could check the error code and display a localized error message
		view?.displayFollowerDMRetrievalError(title: "Error", message: error.localizedDescription)
	}

    fileprivate func handleDMPosted(dm: DM) {
        followerDMs.append(dm)
        view?.refreshFollowerDMView()
    }
    
    fileprivate func handleDMPostError(_ error: Error) {
        view?.displayDMPostError(title: "Error", message: error.localizedDescription)
    }
}
