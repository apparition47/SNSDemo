//
//  ApiFollowersGatewayTest.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/20.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import XCTest
@testable import SNS_Demo

class ApiFollowersGatewayTest: XCTestCase {
    var apiGatewaySpy = ApiFollowersGatewaySpy()
    var cacheGateway: CacheFollowersGateway!
    
    override func setUp() {
        super.setUp()
        cacheGateway = CacheFollowersGateway(apiFollowersGateway: apiGatewaySpy)
    }
    
    // MARK: - Tests
    
    func testListCacheGetSuccess() {
        let listToReturn = [DM]() // TODO use JSON stub insetad
        let expectedResultToReturn: Result<[DM]> = .success(listToReturn)
        
        apiGatewaySpy.fetchDMResultToBeReturned = expectedResultToReturn
        let completionExpectation = expectation(description: "Get List completion expectation")

        let params = FetchDMParameters(email: "test@example.com")
        cacheGateway.fetchDM(parameters: params) { res in
            XCTAssertEqual(expectedResultToReturn, res, "The expected result wasn't returned")

            completionExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testListCacheGetFailure() {
        let expectedResultToReturn: Result<[DM]> = .failure(CoreError(message: "Error occurred"))
        
        apiGatewaySpy.fetchDMResultToBeReturned = expectedResultToReturn
        let completionExpectation = expectation(description: "Fetch DM completion expectation")
        
        let params = FetchDMParameters(email: "test@example.com")
        cacheGateway.fetchDM(parameters: params) { res in
            XCTAssertEqual(expectedResultToReturn, res, "The expected result wasn't returned")
            
            completionExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
