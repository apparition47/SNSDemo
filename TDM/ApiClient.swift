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
    var currentUser: User? { get }
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
    
    var currentUser: User? {
        guard let firUser = Auth.auth().currentUser else {
            return nil
        }
        return User(email: firUser.email ?? "")
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
                if let error = error {
                    completion(.failure(error))
                }
                if let firUser = authResult?.user {
                    completion(.success(User(email: firUser.email ?? "")))
                }
        }
    }
    
    func logout(completion: @escaping (Result<Void>) -> ()) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            completion(.success( () ))
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            completion(.failure(signOutError))
        }
    }
    
    func execute<T: ApiRequest>(_ request: T, completion: @escaping (Result<T.ResponseType>) -> ()) {
        print(request.query.description)
        
        switch request.method {
        case .get:
            let colRef = db.collection(request.query.description)
            var query: Query?
            if let orderBy = request.orderBy {
                query = colRef.order(by: orderBy, descending: request.orderDesc)
            }
            if let limit = request.limit {
                query = colRef.limit(to: limit)
            }
            (query ?? colRef).getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    completion(.failure(err))
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
                
                if let payload = try! querySnapshot?.data(as: T.ResponseType.self) {
                    completion(.success(payload))
                } else {
                    completion(.failure(NSError()))
                }
            }
        case .put:
            guard var parameters = request.parameters else {
                completion(Result.failure(NSError()))
                return
            }
            parameters["timestamp"] = Timestamp(date: Date())
            db.document(request.query.description).setData(parameters) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                    completion(.failure(err))
                } else {
                    print("Document successfully written!")
                    completion(.success(NullCodable() as! T.ResponseType))
                }
            }
        case .post:
            guard var parameters = request.parameters else {
                completion(Result.failure(NSError()))
                return
            }
            parameters["timestamp"] = Timestamp(date: Date())
            db.collection(request.query.description).addDocument(data: parameters) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                    completion(.failure(err))
                } else {
                    print("Document successfully written!")
                    completion(.success(NullCodable() as! T.ResponseType))
                }
            }
        case .delete:
            db.document(request.query.description).delete { err in
                if let err = err {
                    print("Error writing document: \(err)")
                    completion(.failure(err))
                } else {
                    print("Document successfully written!")
                    completion(.success(NullCodable() as! T.ResponseType))
                }
                
            }
        }
    }

}

