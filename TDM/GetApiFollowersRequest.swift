//
//  GetApiFollowersRequest.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation


struct GetFollowersApiRequest: ApiRequest {

    // intermediate JSON response structure
//    fileprivate struct RawServerResponse: Decodable {
//        var users: ResponseType
//    }
//
//    static func decode(from data: Data) -> Result<ResponseType> {
//        do {
//            let raw = try JSONDecoder().decode(RawServerResponse.self, from: data)
//            return .success(raw.users)
//        } catch {
//            print("error trying to convert data to JSON")
//            print(error)
//            return .failure(NSError.createParseError())
//        }
//    }
    
    typealias ResponseType = [User]
    
    var query: DocumentQuery {
        .timelines
    }
    
//    let getFollowersParameters: FetchFollowersParameters
    
//    let path = "/followers/list.json"
//    var parameters: [String: Any]? {
//        return getFollowersParameters.toDictionary()
//    }
//    static let responseKeyPath: [String] = ["users"]
}

//extension FetchFollowersParameters {
//    func toDictionary() -> [String: Any] {
//        let dictionary = [String: Any]()

//        if let page = page {
//            dictionary["page"] = page
//        }
//
//        if let query = query {
//            dictionary["q"] = query
//        }

//        return dictionary
//    }
//}

