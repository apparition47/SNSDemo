//
//  ApiRequest.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

enum DocumentQuery {
    case timelines
    case timeline(email: String)
    case timelinePosts(email: String)
//    case post(email: String, uid: String)
}

enum HTTPMethod {
    case get, post, delete, put
}

extension DocumentQuery {
    var description: String {
        switch self {
        case .timelines: return "timelines"
        case .timeline(let email): return "timelines/\(email)"
        case .timelinePosts(let email): return "timelines/\(email)/posts"
//        case .post(let email): return "timelines/\(email)/posts"
        }
    }
}

protocol ApiRequest {
//    var baseUrl: String { get }
    var query: DocumentQuery { get }
    var parameters: [String: Any]? { get }
//    var headers: [String: String]? { get }
    var method: HTTPMethod { get }
    var orderBy: String? { get }
    var orderDesc: Bool { get }
    var limit: Int? { get }
    associatedtype ResponseType: Codable
//    static func decode(from data: Data) -> Result<ResponseType>
}

extension ApiRequest {
//    var baseUrl: String {
//        let apiVersion = "1.1"
//        return "https://api.twitter.com/\(apiVersion)"
//    }
    
    var parameters: [String: Any]? { nil }
    var method: HTTPMethod { .get }
    var orderBy: String? { nil }
    var orderDesc: Bool { true }
    var limit: Int? { nil }

//    var headers: [String: String]? {
//        return nil
//    }

}

extension NSError {
    static func createParseError() -> NSError {
        return NSError(domain: "com.onefatgiraffe.TDM",
                       code: 999,
                       userInfo: [NSLocalizedDescriptionKey: "A parsing error occured"])
    }
}
