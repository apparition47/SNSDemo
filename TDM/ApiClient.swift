//
//  ApiRequest.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

protocol ApiClient {
    func login(completion: @escaping (Result<Void>) -> ())
    func execute<T: ApiRequest>(_ request: T, completion: @escaping (Result<T.ResponseType>) -> ())
}

class ApiClientImplementation: ApiClient {

    private var client: TWTRAPIClient?

    init() {
        
    }
	
	// MARK: - ApiClient

    func login(completion: @escaping (Result<Void>) -> ()) {
        Twitter.sharedInstance().logIn(completion: { (session, error) in
            if let session = session {
                self.client = TWTRAPIClient(userID: session.userID)
                completion( .success(()) )
//                print("signed in as \(sess.u)");
            } else {
                completion(.failure(error!))
//                print("error: \(error.localizedDescription)");
            }
        })
    }
    
    func execute<T: ApiRequest>(_ request: T, completion: @escaping (Result<T.ResponseType>) -> ()) {
        guard let client = client else {
            return completion( .failure(NSError()) )
        }
        
        let urlString = request.baseUrl + request.path
        var clientError: NSError?
        
        let request = client.urlRequest(withMethod: request.method.rawValue, url: urlString, parameters: request.parameters, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
//                print("Error: \(connectionError)")
                completion(.failure(NSError()))
            }
            
            if let data = data {
                completion(T.decode(from: data))
            } else {
                completion(.failure(NSError()))
            }
        }
    }

}
