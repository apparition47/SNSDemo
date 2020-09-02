//
//  FetchDMCaseTest.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/21.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import XCTest
@testable import SNS_Demo

class FetchDMCaseTest: XCTestCase {
    
    let gatewaySpy = FollowersGatewaySpy()
    
    var fetchDMUseCase: FetchDMUseCaseImplementation!
    
    override func setUp() {
        super.setUp()
        fetchDMUseCase = FetchDMUseCaseImplementation(followersGateway: gatewaySpy)
    }
    
    func testFetchSuccess() {
        let listResultToBeReturned = [DM]()
        let expectedResultToBeReturned: Result<[DM]> = Result.success(listResultToBeReturned)
        gatewaySpy.fetchDMResultToBeReturned = expectedResultToBeReturned
        
        let completionExpectation = expectation(description: "Fetch Expectation")
        let params = FetchDMParameters(email: "test@example.com")
        fetchDMUseCase.fetch(parameters: params) { result in
            XCTAssertEqual(expectedResultToBeReturned, result, "Completion didn't return the expected result")
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchFailure() {
        let expectedResultToBeReturned: Result<[DM]> = Result.failure(CoreError(message: "Failed to fetch"))
        gatewaySpy.fetchDMResultToBeReturned = expectedResultToBeReturned
        
        let completionExpectation = expectation(description: "Fetch Expectation")
        
        let params = FetchDMParameters(email: "test@example.com")
        fetchDMUseCase.fetch(parameters: params) { result in
            XCTAssertEqual(expectedResultToBeReturned, result, "Completion didn't return the expected result")
            completionExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
