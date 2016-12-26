//
//  File.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/21.
//
//

import MiniPromiseKit
import SwiftKuery

extension Connection {
    func connect() -> Promise<Void> {
        return Promise { fulfill, reject in
            self.connect() { error in
                if let error = error {
                    reject(error)
                } else {
                    fulfill()
                }
            }
        }
    }
}

extension Query {
    
    func execute(_ connection: Connection) -> Promise<QueryResult> {
        return Promise { fulfill, reject in
            self.execute(connection) { result in
                fulfill(result)
            }
        }
    }
}
