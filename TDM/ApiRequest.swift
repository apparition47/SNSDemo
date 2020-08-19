//
//  ApiRequest.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol ApiRequest {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    associatedtype ResponseType: Codable
    static func decode(from data: Data) -> Result<ResponseType>
}

extension ApiRequest {
    var baseUrl: String {
        let apiVersion = "1.1"
        return "https://api.twitter.com/\(apiVersion)"
    }
    
    var path: String {
        return "/"
    }
    
    var method: HTTPMethod {
        return HTTPMethod.get
    }

    var headers: [String: String]? {
        return nil
    }

}

extension NSError {
    static func createParseError() -> NSError {
        return NSError(domain: "com.onefatgiraffe.TDM",
                       code: 999,
                       userInfo: [NSLocalizedDescriptionKey: "A parsing error occured"])
    }
}
