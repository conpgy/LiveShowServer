//
//  DatabaseLive.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/23.
//
//

import SwiftKuery
import MiniPromiseKit
import LoggerAPI

extension Database {
    
    func queryLiveUrl(roomId: Int) -> Promise<String> {
        
        let select = Select(from: Database.liverUrlTable).where(Database.liverUrlTable.roomId == roomId)
        
        let connection = createConnection()
        
        return firstly {
            
            connection.connect()
            
        }.then(on: queue) { () -> Promise<QueryResult> in
            
            select.execute(connection)
            
        }.then(on: queue) { result -> ResultSet in
            
            guard let resultSet = result.asResultSet else {throw LiveShowError.noResult}
            return resultSet
            
        }.then(on: queue) { resultSet -> String in
            
            let fields = resultToRows(resultSet: resultSet)
            return fields.first?["url"] as! String? ?? ""
            
        }.always(on: queue) {
            connection.closeConnection()
        }
    }
}
