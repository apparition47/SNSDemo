//
//  PostDMApiRequest.swift
//  TDM
//
//  Created by Aaron Lee on 2020/08/22.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation

struct PostDMApiRequest: ApiRequest {
    typealias ResponseType = NullCodable
    
    var query: DocumentQuery {
//        .post(email: email, uid: uid)
        .timelinePosts(email: email)
    }
    var method: HTTPMethod {
        .post
    }
    var parameters: [String : Any]? {
        ["message": message, "from": email]
    }
    
    let email: String
//    let uid: String
    let message: String
}
