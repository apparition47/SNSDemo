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
        .post(email: timelineEmail, uid: uid)
    }
    
    var method: HTTPMethod {
        .put
    }
    
    var parameters: [String : Any]? {
        ["uid": uid, "message": message, "from": fromEmail]
    }
    
    let timelineEmail: String
    let fromEmail: String
    let uid: String = UUID().uuidString
    let message: String
}
