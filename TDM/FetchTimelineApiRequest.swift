//
//  FetchTimelineApiRequest.swift
//  TDM
//
//  Created by Aaron Lee on 2020/08/22.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation

struct FetchTimelineApiRequest: ApiRequest {
    typealias ResponseType = [DM]
    
    var query: DocumentQuery {
        .timelinePosts(email: email)
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var orderBy: String? {
        "timestamp"
    }
    
    let email: String
}
