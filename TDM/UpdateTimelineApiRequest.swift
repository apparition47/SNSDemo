//
//  UpdateTimelineApiRequest.swift
//  TDM
//
//  Created by Aaron Lee on 2020/08/22.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation

struct UpdateTimelineApiRequest: ApiRequest {
    typealias ResponseType = NullCodable
    
    var query: DocumentQuery {
        .timeline(email: email)
    }
    
    var method: HTTPMethod {
        .put
    }
    
    var parameters: [String : Any]? {
        ["email": email]
    }
    
    let email: String
}
