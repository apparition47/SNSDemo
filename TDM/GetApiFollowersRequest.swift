//
//  GetApiFollowersRequest.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation


struct GetFollowersApiRequest: ApiRequest {
    typealias ResponseType = [User]
    
    var query: DocumentQuery {
        .timelines
    }
}
