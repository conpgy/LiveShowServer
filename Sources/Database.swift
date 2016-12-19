//
//  Database.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/19.
//
//

import Foundation
import SwiftKuery
import SwiftKueryPostgreSQL
import MiniPromiseKit


class Database {
    
    let queue = DispatchQueue(label: "com.liveshow-database", attributes: .concurrent)
    
    static let accessStatisticTable = AccessStatisticTable()
    
    private func createConnection() -> Connection {
        return PostgreSQLConnection(host: Config.databaseHost, port: Config.databasePort,
                                    options: [.userName(Config.databaseUserName),
                                              .password(Config.databasePassword),
                                              .databaseName(Config.databaseName)])
    }
    
//    func queryPv(with selection: Select) -> Promise<Int> {
//        
//        let connection = createConnection()
//    
//        return firstly {
//            connection.connect()
//        }
//        .then(on: queue) { result -> Promise<QueryResult> in
//            selection.execute(connection)
//        }.then(on: queue) { result -> ResultSet in
//            guard let resultSet = result.asResult else {
//                throw Error()
//            }
//            return resultSet
//            
//        }.then(on: queue) { resultSet -> Int in
//            
//            }.always(on: queue) {
//                connection.closeConnection()
//        }
//    }
    
    func queryPV() -> Promise<String> {
        
        let select = Select(from: Database.accessStatisticTable).where(Database.accessStatisticTable.id == 1)
        
        let connection = createConnection()
        
        return firstly {
            connection.connect()
            }
            .then(on: queue) { result -> Promise<QueryResult> in
                select.execute(connection)
            }
            .then(on: queue) { result -> ResultSet in
                guard let resultSet = result.asResultSet else { throw LiveShowError.noResult }
                return resultSet
            }.then(on: queue) { resultSet -> String in
                
                
                let t = resultSet.rows.map { zip(resultSet.titles, $0) }
                
                var dicts = [String: Any]()
                let _ = t.map {
                    $0.forEach {
                        let (title, value) = $0
                        dicts[title] = value
                    }
                }
                print(dicts)
                return dicts["pv"] as? String ?? "0"
                
            }.always(on: queue) {
                connection.closeConnection()
        }
    }
    
    func updatePV() {
        
//        let connection = createConnection()
//        var update:Update?
//        
//        let _ = firstly { () -> Promise<String> in
//            self.queryPV()
//            
//            }.then(on: self.queue) { pV in
//                print("pv: \(pV)")
//            
//                // 访问量加1
//                update = Update(Database.accessStatisticTable, set: [(Database.accessStatisticTable.pv, pV)], where: Database.accessStatisticTable.id == 1)
//                
//            }.then(on: self.queue) { Promise<Void> in
//                connection.connect()
//            }.then (on: self.queue) {
//                update?.execute(connection)
//        
//            }.catch(on: self.queue) { error in
//                
//            }.always {
//                connection.closeConnection()
//        }
    }
    
}


public extension Connection {
    
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

public extension Query {
    
    func execute(_ connection: Connection ) -> Promise<QueryResult> {
        return Promise { fulfill, reject in
            self.execute( connection) { result in
                fulfill(result)
            }
        }
    }
    
}
