//
//  Firestore+QuerySnapshot.swift
//  TDM
//
//  Created by Aaron Lee on 2020/08/22.
//  Copyright © 2020 Aaron Lee. All rights reserved.
//

import Firebase
import FirebaseFirestore

// hack: analog of doc.data(as: T.Type) but for collections
extension QuerySnapshot {
    public func data<T: Decodable>(as type: T.Type) throws -> T? {
        let dic: [[String : Any]]? = documents.compactMap { doc in
            var res = doc.data()
            res.removeValue(forKey: "timestamp")
            return res
        }
        let jsonData = try? JSONSerialization.data(withJSONObject: dic as Any, options: [])
        return try? JSONDecoder().decode(T.self, from: jsonData!)
    }
}
