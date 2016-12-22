//
//  DatabaseAnchor.swift
//  LiveShowServer
//
//  Created by penggenyong on 2016/12/22.
//
//

import SwiftKuery
import MiniPromiseKit
import LoggerAPI

extension Database {
    
    func anchors(with type: Int, start:Int, pageSize: Int) -> Select {
        return Select(from: Database.anchorTable)
            .where(Database.anchorTable.type == type)
            .offset(start * pageSize)
            .limit(to: pageSize)
    }
    
    func queryAnchors(with selection: Select) -> Promise<[Anchor]> {
        
        let connection = createConnection()
        
        return firstly {
            
            connection.connect()
            
        }.then(on: queue) { result -> Promise<QueryResult> in
            
            selection.execute(connection)
            
        }.then(on: queue) { result -> ResultSet in
            
            guard let resultSet = result.asResultSet else { throw LiveShowError.noResult }
            return resultSet
            
        }.then(on: queue) { resultSet -> [Anchor] in
            
            let fields = resultToRows(resultSet: resultSet)
            return fields.flatMap(Anchor.init(fields:))
            
        }.always(on: queue) {
            
            connection.closeConnection()
            
        }
    }
    
    func insert(with anchor: Anchor) -> Promise<Void> {
        
        let anchorTable = Database.anchorTable
        let insert = Insert(into: anchorTable,
                            columns: [
                                anchorTable.uid,
                                anchorTable.roomId,
                                anchorTable.type,
                                anchorTable.push,
                                anchorTable.name,
                                anchorTable.isLive,
                                anchorTable.focus,
                                anchorTable.pic51,
                                anchorTable.pic74
                            ], values: [
                                String(anchor.uid),
                                String(anchor.roomId),
                                String(anchor.type),
                                String(anchor.push),
                                anchor.name,
                                anchor.isLive ? "1":"0",
                                String(anchor.focus),
                                anchor.pic51,
                                anchor.pic74
                            ])
        
        let connection = createConnection()
        
        return firstly {
            connection.connect()
        }.then(on: queue) {
            insert.execute(connection)
        }.then(on: queue) { result -> Void in
            if let error = result.asError {
                Log.error(error.localizedDescription)
                throw LiveShowError.databaseError("insert anchor error")
            }
        }.always(on: queue) {
                connection.closeConnection()
        }
    }
}
