//
//  Result.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

struct CoreError: Error {
	var localizedDescription: String {
		return message
	}
	
	var message = ""
}

enum Result<T> {
	case success(T)
	case failure(Error)
	
	public func dematerialize() throws -> T {
		switch self {
		case let .success(value):
			return value
		case let .failure(error):
			throw error
		}
	}
}
