//
//  FollowerDMViewRouterSpy.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/21.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

@testable import SNS_Demo

class FollowerDMViewRouterSpy: FollowerDMViewRouter {
    var dismissViewCalled = false
    
    func dismissView() {
        dismissViewCalled = true
    }
}
