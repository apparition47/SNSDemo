//
//  DeletePostApiRequest.swift
//  TDM
//
//  Created by Aaron Lee on 2020/08/21.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Foundation

struct DeletePostApiRequest: ApiRequest {
    typealias ResponseType = NullCodable
    
    var query: DocumentQuery {
        .post(email: email, uid: uid)
    }
    var method: HTTPMethod {
        .delete
    }
    
    let email: String
    let uid: String
}
