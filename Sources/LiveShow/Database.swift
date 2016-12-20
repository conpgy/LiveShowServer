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
    func queryAndUpdatePV() -> Int {
        
        var pv: Int = 0
        
        let select = Select(from: Database.accessStatisticTable).where(Database.accessStatisticTable.id == 1)
        
        let connection = createConnection()
        connection.connect { error in
            if let error = error {
                Log.error(error.localizedDescription)
                return
            }

        }
        
        connection.execute(query: select) { queryResult in
            guard let resultSet = queryResult.asResultSet else {
                return
            }
            
            let t = resultSet.rows.map { zip(resultSet.titles, $0) }
            let _ = t.map {
                $0.forEach {
                    let (title, value) = $0
                    if title == "pv", let value = value, let valueString = value as? String {
                        pv = Int(valueString) ?? 0
                        return
                    }
                }
            }
        }
        
        // update pv
        pv += 1
        
        let update = Update(Database.accessStatisticTable, set: [(Database.accessStatisticTable.pv, pv)], where: Database.accessStatisticTable.id == 1)
        connection.execute(query: update) { result in
            if let error = result.asError {
                Log.error("update pv failed: " + error.localizedDescription)
            }
        }
        
        return pv
    }
    
}
