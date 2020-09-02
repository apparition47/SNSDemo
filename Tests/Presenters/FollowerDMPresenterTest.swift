//
//  FollowerDMPresenterTest.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/18.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import XCTest
@testable import SNS_Demo

class FollowerDMPresenterTest: XCTestCase {
    
    let passedFollower = User(email: "test@example.com")
    let loginDMUseCaseSpy = LoginUseCaseSpy()
    let postDMUseCaseSpy = PostDMUseCaseSpy()
    let fetchDMUseCaseSpy = FetchDMUseCaseSpy()
    let deleteDMUseCaseSpy = DeleteDMUseCaseSpy()
    let routerSpy = FollowerDMViewRouterSpy()
    let viewSpy = FollowerDMViewSpy()

    var presenter: FollowerDMPresenterImplementation!

    // MARK: - Set up

    override func setUp() {
        super.setUp()
        presenter = FollowerDMPresenterImplementation(view: viewSpy, follower: passedFollower, loginUseCase: loginDMUseCaseSpy, postDMUseCase: postDMUseCaseSpy, fetchDMUseCase: fetchDMUseCaseSpy, deleteDMUseCase: deleteDMUseCaseSpy, router: routerSpy)
    }

    // MARK: - Tests

}
