//
//  Follower.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

// https://developer.twitter.com/en/docs/accounts-and-users/follow-search-get-users/api-reference/get-followers-list
struct Follower: Codable {
    let id: Int
    let name: String
    let screen_name: String
    let protected: Bool
    let profile_image_url_https: String
    let profile_background_image_url_https: String
}

extension Follower: Equatable { }

func == (lhs: Follower, rhs: Follower) -> Bool {
    return lhs.id == rhs.id
}

// "Implementation of Decodable cannot be automatically synthesized in an extension yet"
//extension Follower: Codable { }
