//
//  Helpers.swift
//  Tests
//
//  Created by Aaron Lee on 2019/09/21.
//  Copyright © 2019 Aaron Lee. All rights reserved.
//

import Foundation
@testable import SNS_Demo

extension Result: Equatable { }
public func ==<T>(lhs: Result<T>, rhs: Result<T>) -> Bool {
    return String(describing: lhs) == String(describing: rhs)
}
