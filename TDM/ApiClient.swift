//
//  ApiRequest.swift
//  TDM
//
//  Created by Aaron Lee on 2017/12/06.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation
import Firebase

protocol ApiClient {
    var isLoggedIn: Bool { get }
    func didUserStateChange(callback: @escaping (User?) -> ())
    func signup(email: String, password: String, completion: @escaping (Result<User>) -> ())
    func login(email: String, password: String, completion: @escaping (Result<User>) -> ())
    func logout(completion: @escaping (Result<Void>) -> ())
    func execute<T: ApiRequest>(_ request: T, completion: @escaping (Result<T.ResponseType>) -> ())
}

class ApiClientImplementation: ApiClient {
    private let db = Firestore.firestore()
    private var authDidChangeListener: AuthStateDidChangeListenerHandle?
    
	// MARK: - ApiClient
    
    var isLoggedIn: Bool {
        Auth.auth().currentUser != nil
    }
    
    func didUserStateChange(callback: @escaping (User?) -> ()) {
        authDidChangeListener = Auth.auth().addStateDidChangeListener { (auth, firUser) in
            callback(firUser != nil ? User(email: firUser?.email ?? "") : nil)
        }
    }
    
    func signup(email: String, password: String, completion: @escaping (Result<User>) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            }
            if let firUser = authResult?.user {
                completion(.success(User(email: firUser.email ?? "")))
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<User>) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
          // ...
        }
    }
    
    func logout(completion: @escaping (Result<Void>) -> ()) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func execute<T: ApiRequest>(_ request: T, completion: @escaping (Result<T.ResponseType>) -> ()) {
        let docRef = db.document(request.query.description)
        switch request.query {
        case .timeline, .timelines:
            let colRef = db.collection(request.query.description)
            var query: Query?
            if let orderBy = request.orderBy {
                query = colRef.order(by: orderBy, descending: request.orderDesc)
            }
            if let limit = request.limit {
                query = colRef.limit(to: limit)
            }
            (query ?? colRef).getDocuments { (querySnapshot, err) in
                if let payload = querySnapshot?.documents as? T.ResponseType {
                    completion(.success(payload))
                } else {
                    completion(.failure(NSError()))
                }
            }
        case .post:
            guard let parameters = request.parameters else {
                completion(Result.failure(NSError()))
                return
            }
            switch request.method {
            case .post:
                docRef.setData(parameters) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            case .delete:
                docRef.delete { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            default: break
            }
        }
    }

}
