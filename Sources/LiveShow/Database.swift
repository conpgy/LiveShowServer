//
//  Database.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/19.
//
//

import Dispatch
import SwiftKuery
import SwiftKueryPostgreSQL
import MiniPromiseKit
import LoggerAPI


class Database {
    
    let queue = DispatchQueue(label: "com.liveshow-database", attributes: .concurrent)
    
    static let accessStatisticTable = AccessStatisticTable()
    
    private func createConnection() -> Connection {
        return PostgreSQLConnection(host: PrivateConfig.databaseHost, port: PrivateConfig.databasePort,
                                    options: [.userName(PrivateConfig.databaseUserName),
                                              .password(PrivateConfig.databasePassword),
                                              .databaseName(PrivateConfig.databaseName)])
    }
    
    
    /// query the pv, and update with pv+1
    func queryAndUpdatePV() -> Promise<Int> {
        
        let select = Select(from: Database.accessStatisticTable).where(Database.accessStatisticTable.id == 1)
        let connection = createConnection()
        
        
        return firstly {
            
            connection.connect()
            
        }.then(on: queue) { () -> Promise<QueryResult> in
            
            select.execute(connection)
            
        }.then(on: queue) {result -> ResultSet in
            
            guard let resultSet = result.asResultSet else {throw LiveShowError.noResult}
            return resultSet
            
        }.then(on: queue) { resultSet -> Int in
            
            var pv = 0
            let fields = resultToRows(resultSet: resultSet)
            
            if let pvStr = fields.first?["pv"] as? String, let PV = Int(pvStr) {
                pv = PV
            }
            return pv
            
        }.then(on: queue) { pv -> Int in
                
                // update 
                let updatePv = pv + 1
                let update = Update(Database.accessStatisticTable, set: [(Database.accessStatisticTable.pv, updatePv)], where: Database.accessStatisticTable.id == 1)
                let _ = update.execute(connection)
                return updatePv
                
        }.always(on: queue) {
            connection.closeConnection()
        }
    }
    
}
