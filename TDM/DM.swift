//
//  Follower.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

struct DM {
    let message: String
    let isFromSelf: Bool
}

extension DM: Equatable { }

func == (lhs: DM, rhs: DM) -> Bool {
    return lhs.message == rhs.message && lhs.isFromSelf == rhs.isFromSelf
}
