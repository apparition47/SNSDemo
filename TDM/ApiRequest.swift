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
    case post(email: String, uid: String)
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
        case .post(let email, let uid):
            return "timelines/\(email)/posts/\(uid)"
        }
    }
    
    // Document references must have an even number of segments
    var isCollection: Bool {
        description.split(separator: "/").count % 2 == 1
    }
}

protocol ApiRequest {
    var query: DocumentQuery { get }
    var parameters: [String: Any]? { get }
    var method: HTTPMethod { get }
    var orderBy: String? { get }
    var orderDesc: Bool { get }
    var limit: Int? { get }
    associatedtype ResponseType: Codable
}

extension ApiRequest {
    var parameters: [String: Any]? { nil }
    var method: HTTPMethod { .get }
    var orderBy: String? { nil }
    var orderDesc: Bool { false }
    var limit: Int? { nil }
}

extension NSError {
    static func createParseError() -> NSError {
        return NSError(domain: "com.onefatgiraffe.TDM",
                       code: 999,
                       userInfo: [NSLocalizedDescriptionKey: "A parsing error occured"])
    }
}
