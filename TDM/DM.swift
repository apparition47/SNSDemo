//
//  Follower.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

struct DM: Codable {
    let uid: String
    let message: String
//    let timestamp: Date
    let from: String // email
    
    var isFromSelf: Bool { true }
}

extension DM: CustomStringConvertible {
    var description: String {
        "[\(uid)] \(from): \(message)"
    }
}

extension DM: Equatable { }

func == (lhs: DM, rhs: DM) -> Bool {
    return lhs.uid == rhs.uid
}
